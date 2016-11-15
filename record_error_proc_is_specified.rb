require_relative '../automated_init'

context "Record Error Proc is Supplied to Host" do
  record_error_proc = proc { }

  host = Host.new

  host.record_error &record_error_proc

  test "Record error proc is set" do
    assert host.record_error_proc == record_error_proc
  end
end
