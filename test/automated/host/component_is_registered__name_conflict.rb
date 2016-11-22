require_relative '../automated_init'

context "Component is Registered With Host, Name Conflict" do
  component_1 = Controls::Component.example
  component_2 = Controls::Component.example

  host = Host.new

  host.register component_1, 'some-name'

  test "NameConflictError is raised" do
    assert proc { host.register component_2, 'some-name' } do
      raises_error? Host::NameConflictError
    end
  end
end
