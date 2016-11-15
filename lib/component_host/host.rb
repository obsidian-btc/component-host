module ComponentHost
  class Host
    include Log::Dependency

    attr_accessor :name
    attr_writer :record_error_proc

    def self.build(name=nil)
      instance = new
      instance.name = name if name
      instance
    end

    def record_error(&block)
      self.record_error_proc = block
    end

    def register(cls, name=nil)
      logger.trace { "Registering component (Name: #{name.inspect}, Class: #{cls.name.inspect})" }

      name ||= cls.default_name

      components[name] = cls

      logger.debug { "Component registered (Name: #{name.inspect}, Class: #{cls.name.inspect})" }

      cls
    end

    def components
      @components ||= {}
    end

    def start
      Actor::Supervisor.start do |supervisor|
        Signal.trap 'INT' do
          logger.info { "Interrupt signal trapped; shutting down" }

          Actor::Messaging::Write.(Actor::Messages::Shutdown, supervisor.address)
        end

        Signal.trap 'TSTP' do
          logger.info { "Stop signal trapped; suspending components" }

          Actor::Messaging::Write.(Actor::Messages::Suspend, supervisor.address)
        end

        Signal.trap 'CONT' do
          logger.info { "Continue signal trapped; resuming components" }

          Actor::Messaging::Write.(Actor::Messages::Resume, supervisor.address)
        end

        components.each_value do |cls|
          cls.start
        end

        name = self.name || '<none>'

        logger.info { "Process started (Name: #{name})" }
      end

    rescue => error
      logger.fatal "Error raised; exiting process (Class: #{error.class.name}, Message: #{error.message.inspect})"
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
