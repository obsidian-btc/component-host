require_relative '../automated_init'

context "Host is Started" do
  supervisor_address = nil

  component_cls = Class.new do
    include Component

    define_method :start do
      supervisor_address = Actor::Supervisor::Address::Get.()

      Controls::Actor::StopImmediately.start
    end
  end

  host = Host.build

  host.register component_cls

  host.start

  test "Actor supervisor is started" do
    assert supervisor_address do
      instance_of? Actor::Messaging::Address
    end
  end
end
