#!/usr/bin/env ruby
require 'socket'
require 'time'

def socket
  @socket ||= TCPSocket.new ARGV[0], ARGV[1]
end

def generate_metric(mps)
  @metric_id ||= 0

  if @metric_id >= 4000 # Make sure we have enough id's to match our message per second times the size of our smallest metric
  #if @metric_id >= mps # Make sure we have enough id's to match our message per second times the size of our smallest metric
    @metric_id = 1 
  else
    @metric_id += 1
  end

  random = (rand * 2000).to_i
  timestamp = Time.now.to_i
  "krux.test-#{@metric_id} #{random} #{timestamp}"
end

def run_test(mps, count, duration = nil)
  interval = 1.0 / (mps / count)
  testid = (rand * 10000).to_i

  puts "#{Time.now} #{mps.to_i} messages/sec"

  last = Time.now
  start = Time.now

  while true do
    if duration && (Time.now - start > duration)
      puts
      return
    end

    if Time.now - last > interval
      metrics = []
      count.times do
        metrics << generate_metric(mps)
      end
      puts metrics.join("\n")
      socket.puts metrics.join("\n")
      #print "."
      last = Time.now
    else
      sleep(interval - (Time.now - last))
    end
  end
end

run_test(ARGV[2].to_f, ARGV[3].to_i)

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
