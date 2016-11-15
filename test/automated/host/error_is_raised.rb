require_relative '../automated_init'

context "Error is Raised by a Component" do
  context "No error handler is specified" do
    host = Host.build
    host.register Controls::Component::RaiseError

    test "Error is raised" do
      assert proc { host.start } do
        raises_error? Controls::Error::Example
      end
    end
  end

  context "Error handler is specified" do
    error = nil

    host = Host.build
    host.register Controls::Component::RaiseError

    host.record_error do |err|
      error = err
    end

    test "Error is raised" do
      assert proc { host.start } do
        raises_error? Controls::Error::Example
      end
    end

    test "Error handler is invoked with the error as an argument" do
      assert error == Controls::Error.example
    end
  end
end
