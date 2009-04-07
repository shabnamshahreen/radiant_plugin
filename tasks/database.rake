namespace :radiant do
  namespace :db do

    desc "Migrate schema to version 0 and back up again. WARNING: Destroys all data in tables!!"
    task :remigrate => :environment do
      unless defined?(RADIANT_ROOT) or ENV['RADIANT_ROOT']
        require File.join(File.dirname(__FILE__), '..', 'init')
      end
      RADIANT_ROOT = ENV['RADIANT_ROOT'] unless defined?(RADIANT_ROOT)
      require 'highline/import'
      require File.join(RADIANT_ROOT, 'ext_lib', 'radiant_cms_migrator')
      if ENV['OVERWRITE'].to_s.downcase == 'true' or agree("This task will destroy any data in the database. Are you sure you want to \ncontinue? [yn] ")
        
        # Migrate downward
        ActiveRecord::RadiantCmsMigrator.migrate("#{RADIANT_ROOT}/db/migrate/", 0)
      
        # Migrate upward 
        Rake::Task["radiant:db:migrate"].invoke
        
        # Dump the schema
        Rake::Task["db:schema:dump"].invoke
      else
        say "Task cancelled."
        exit
      end
    end

    desc "Migrate RadiantCMS"
    task :migrate => :environment do
      unless defined?(RADIANT_ROOT) or ENV['RADIANT_ROOT']
        require File.join(File.dirname(__FILE__), '..', 'init')
      end
      RADIANT_ROOT = ENV['RADIANT_ROOT'] unless defined?(RADIANT_ROOT)
      require File.join(RADIANT_ROOT, 'ext_lib', 'radiant_cms_migrator')
      ActiveRecord::RadiantCmsMigrator.migrate("#{RADIANT_ROOT}/db/migrate", ENV['VERSION'] ? ENV['VERSION'].to_i : nil)
    end
  
    desc "Bootstrap your database for Radiant."
    task :bootstrap => :remigrate do
      require 'radiant/setup'
      Radiant::Setup.bootstrap(
        :admin_name => ENV['ADMIN_NAME'],
        :admin_username => ENV['ADMIN_USERNAME'],
        :admin_password => ENV['ADMIN_PASSWORD'],
        :database_template => ENV['DATABASE_TEMPLATE']
      )
    end

  end
end
