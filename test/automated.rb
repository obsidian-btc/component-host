ENV['TEST_BENCH_TEST_DIR'] ||= 'test/automated'

require_relative './test_init'

require 'test_bench/cli'

TestBench::CLI.() or exit 1
