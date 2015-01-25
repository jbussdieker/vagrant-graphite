#!/usr/bin/env ruby
require 'socket'

def generate_metric(namespace="foo.")
  random1 = (rand * 30000).to_i
  random2 = (rand * 30000).to_i
  timestamp = Time.now.to_i
  "#{namespace}test-#{random1} #{random2} #{timestamp}"
end

s = TCPSocket.new ARGV[0], ARGV[1]

while true do
  metrics = []
  10.times do
    metrics << generate_metric("foo.")
  end
  s.puts metrics.join("\n")
  print "."
end
