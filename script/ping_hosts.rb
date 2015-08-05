#!/usr/bin/env ruby

require File.expand_path('../../config/environment', __FILE__)
require 'net/ping'

TARGETS_PER_PROCESS=10
NUMBER_OF_PROCESSES=10

DEFAULT_PORT=80
TIMEOUT = 1


0.upto( NUMBER_OF_PROCESSES - 1 ).each do |n|
  batch_size = Target.count / NUMBER_OF_PROCESSES
  extra = Target.count % NUMBER_OF_PROCESSES
  start = batch_size * n
  fork do
    batch_size = batch_size + extra if n == NUMBER_OF_PROCESSES - 1
#    puts "N: #{n} start: #{start} size: #{batch_size}"
    Target.where( ping_enabled: true ).find_in_batches( batch_size: batch_size, start: start ) do |group|

      puts "\n\nGroup: #{Process.pid}\n\n"
      group.each do |target|
        p1 = Net::Ping::TCP.new( target.address, DEFAULT_PORT, TIMEOUT )
        puts "about to ping #{target.hostname}"
        if( p1.ping? )
          puts "#{target.hostname} responded"
          target.transaction do
            target.reachable = true
            target.last_up = Time.now
            target.save
          end
        else
          puts "#{target.hostname} did not respond"
          target.transaction do
            target.reachable = false
            target.save
          end
        end
      end
    end
  end
end
puts "Pings complete"
