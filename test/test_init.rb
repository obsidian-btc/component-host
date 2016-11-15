ENV['CONSOLE_DEVICE'] ||= 'stdout'
ENV['LOG_LEVEL'] ||= '_min'

puts RUBY_DESCRIPTION

require 'pp'

require_relative '../init.rb'

require 'test_bench/activate'

#require 'component_host/controls'
