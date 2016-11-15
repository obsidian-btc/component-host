module ComponentHost
  def self.start(process_name, &block)
    host = Host.build
    host.instance_exec host, &block
    host.start
  end
end
