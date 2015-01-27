#!/usr/bin/env ruby
require 'socket'
require 'time'

def generate_metric(namespace="foo.")
  random1 = (rand * 2000).to_i
  random2 = (rand * 2000).to_i
  timestamp = Time.now.to_i
  "#{namespace}test-#{random1} #{random2} #{timestamp}"
end

def socket
  @socket ||= TCPSocket.new ARGV[0], ARGV[1]
end

def run_test(interval, count, duration)
  mps = (1.0 / interval) * count
  testid = (rand * 10000).to_i

  puts "#{Time.now} #{mps.to_i} messages/sec"

  last = Time.now
  start = Time.now

  while true do
    if Time.now - start > duration
      puts
      return
    end

    if Time.now - last > interval
      metrics = []
      count.times do
        metrics << generate_metric("foo.")
      end
      socket.puts metrics.join("\n")
      #print "."
      last = Time.now
    end
  end
end

run_test(ARGV[2].to_f, ARGV[3].to_i, 60)

#run_test(0.05, 20, 60)
#sleep 10
#run_test(0.04, 50, 60)
#sleep 10
#run_test(0.03, 50, 60)
#sleep 10
#run_test(0.02, 50, 60)
#sleep 10
#run_test(0.01, 50, 60)
#sleep 10
#run_test(0.009, 50, 60)
#sleep 10
#run_test(0.005, 100, 60)
#sleep 10
#run_test(0.004, 100, 60)
#sleep 10
#run_test(0.003, 100, 60)
#sleep 10
#run_test(0.002, 100, 60)
