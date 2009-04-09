module Radiant
  module Version
    Major = '0'
    Minor = '7'
    Tiny  = '1'

    class << self
      def to_s
        [Major, Minor, Tiny].join('.')
      end
      alias :to_str :to_s
    end
  end

  class << self
    def plugin?
      File.dirname(__FILE__).match(/vendor/)
    end
    
    def loaded_via_gem?
      !plugin?
    end
  end
end
