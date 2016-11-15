require_relative './automated_init'

context "Component is Started" do
  start_method_invoked = false

  component_class = Controls::Component::Example.specialize do
    define_method :start do
      start_method_invoked = true
    end
  end

  component_class.start 

  test "Start method is invoked on instance" do
    assert start_method_invoked
  end
end
