module ComponentHost
  class Host
    include Log::Dependency

    attr_accessor :name
    attr_writer :record_error_proc

    def self.build(name=nil)
      instance = new
      instance.name if name
      instance
    end

    def record_error(&block)
      self.record_error_proc = block
    end

    def register(cls, name=nil)
      name ||= cls.default_name

      components[name] = cls
    end

    def components
      @components ||= {}
    end

    def start
      Actor::Supervisor.start do
        components.each_value do |cls|
          cls.start
        end

        name = self.name || '<none>'

        logger.info { "Process started (Name: #{name})" }
      end

    rescue => error
      record_error_proc.(error)
      raise error
    end

    def record_error_proc
      @record_error_proc ||= proc { }
    end

    module Assertions
      def registered?(cls, name=nil)
        name ||= cls.default_name

        component = components.fetch name do
          return false
        end

        component == cls
      end
    end
  end
end
