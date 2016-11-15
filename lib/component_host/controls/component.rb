module ComponentHost
  module Controls
    module Component
      def self.example
        Example.new
      end

      class Example
        include ComponentHost::Component

        def self.specialize(&block)
          Class.new self do
            class_exec &block
          end
        end

        def start
          address = Actor::Example.start

          write.(::Actor::Messages::Stop, address)
        end
      end

      class RaiseError < Example
        def start
          actor_address = Controls::Actor::Example.start

          write.(:raise_error, actor_address)
        end
      end
    end
  end
end
