require_relative '../automated_init'

context "Component is Registered With Host" do
  context do
    cls = Class.new Controls::Component::Example do
      singleton_class.send :attr_accessor, :constructed

      def initialize
        self.class.constructed = true
      end
    end

    host = Host.new

    host.register cls

    test "Component is not yet constructed" do
      refute cls.constructed
    end
  end

  context "Name is not specified" do
    host = Host.new

    host.register Controls::Component::Example

    test "Default name is used" do
      assert host do
        registered? Controls::Component::Example, 'example'
      end
    end
  end

  context "Name is specified" do
    host = Host.new

    host.register Controls::Component::Example, 'other-name'

    test "Default name is used" do
      assert host do
        registered? Controls::Component::Example, 'other-name'
      end
    end
  end
end
