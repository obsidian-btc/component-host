require_relative '../automated_init'

context "Component Default Name" do
  context "String is specified" do
    name = Component::DefaultName.get 'SomeNamespace::SomeClass'

    test "Namespaces are removed and constant name is converted to hyphen casing" do
      assert name == 'some-class'
    end
  end

  context "Component is specified" do
    name = Controls::Component::Example.default_name

    test "Constant name is used" do
      assert name == 'example'
    end
  end
end
