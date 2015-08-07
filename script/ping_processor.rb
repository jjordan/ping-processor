#!/usr/bin/env ruby

require File.expand_path('../../config/environment', __FILE__)
require 'ping_processor'

if PidFile.running?
  puts "already running"
  exit
end

pf = PidFile.new(:piddir => '/tmp',:pidfile => "ping_processor.pid")

Signal.trap("HUP") { puts "SIGHUP and exit"; exit }
Signal.trap("INT") { puts "SIGINT and exit"; exit }
Signal.trap("QUIT") { puts "SIGQUIT and exit"; exit }

pp = PingProcessor.new
pp.run( Target.where( ping_enabled: true ) )
