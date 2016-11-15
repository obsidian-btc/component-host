module ComponentHost
  def self.start(process_name=nil, &block)
    host = Host.build process_name
    host.instance_exec host, &block
    host.start
  end
end
