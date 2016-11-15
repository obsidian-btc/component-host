require_relative './interactive_init'

require 'io/console'

begin
  pid = File.read 'tmp/interactive.pid'
rescue Errno::ENOENT
  fail "#{File.join __dir__, 'start.rb'} must be running"
end

pid = pid.to_i

puts "Press a key corresponding to a signal:"
puts "  i  SIGINT (also exits this script)"
puts "  s  SIGTSTP"
puts "  c  SIGCONT"
puts

loop do
  key = $stdin.getch

  case key
  when 'i'
    Process.kill 'SIGINT', pid
    Process.kill 'SIGINT', Process.pid

  when 's'
    Process.kill 'SIGTSTP', pid

  when 'c'
    Process.kill 'SIGCONT', pid
  end
end
