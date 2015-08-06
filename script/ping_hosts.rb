#!/usr/bin/env ruby

require File.expand_path('../../config/environment', __FILE__)
require 'net/ping'
require 'ping_processor'

pp = PingProcessor.new
pp.run( Target.where( ping_enabled: true ) )
puts "Pings complete"
