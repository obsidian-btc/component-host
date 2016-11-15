require_relative './interactive_init'

pid = Process.pid

File.write 'tmp/interactive.pid', pid.to_s

at_exit { File.unlink 'tmp/interactive.pid' }

module Interactive
  class PrintPeriodically
    include Actor

    attr_writer :counter

    handle :start do
      :print
    end

    handle :print do
      puts "Counter: #{counter}"

      :increment_counter
    end

    handle :increment_counter do
      self.counter += 1

      :sleep
    end

    handle :sleep do
      sleep 0.3

      :print
    end

    def counter
      @counter ||= 0
    end
  end

  class Component
    include ComponentHost::Component

    def start
      PrintPeriodically.start
    end
  end
end

ComponentHost.start 'interactive-test' do |host|
  host.register Interactive::Component
end
