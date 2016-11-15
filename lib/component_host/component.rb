module ComponentHost
  module Component
    def self.included(cls)
      cls.class_exec do
        extend Build
        extend DefaultName
        extend Start

        dependency :write, Actor::Messaging::Write
      end
    end

    module DefaultName
      def default_name
        DefaultName.get self
      end
    end

    module Build
      def build
        instance = new
        instance.write = Actor::Messaging::Write.new
        instance
      end
    end

    module Start
      def start
        instance = build
        instance.start
      end
    end
  end
end
