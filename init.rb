ENV['RADIANT_ROOT'] = RADIANT_ROOT = File.dirname(__FILE__)
require 'radiant'
require 'active_record_extensions'
require 'object_extensions'

ActionController::Response.class_eval do
  attr_accessor :cache_timeout
end
