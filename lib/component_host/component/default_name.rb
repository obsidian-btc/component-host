module ComponentHost
  module Component
    module DefaultName
      def self.get(receiver)
        case receiver
        when String then
          *, const_name = receiver.split '::'

          const_name = Casing::Underscore.(const_name)
          const_name.gsub! '_', '-'
          const_name

        else
          get receiver.to_s
        end
      end
    end
  end
end
