module ComponentHost
  module Controls
    module Actor
      class Example
        include ::Actor

        handle :raise_error do
          error = Error.example

          raise error
        end
      end

      class StopImmediately
        include ::Actor

        handle :start do
          :stop
        end
      end
    end
  end
end
