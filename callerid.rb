#!/usr/bin/env ruby
# encoding: utf-8
require "bundler/setup"
require 'serialport'
require 'yaml'

CONFIG = YAML.load(File.read(File.expand_path('../config.yml', __FILE__)))
SERIAL = CONFIG[:serial] || ( raise "no serial params set" )

action_url    = CONFIG[:action_url] || "/usr/bin/chromium-browser/###callerid###"
serial_device = SERIAL[:device]     || "/dev/ttyS0"
baudrate      = SERIAL[:baudrate]   || 38400
databits      = SERIAL[:databits]   || 8
stopbits      = SERIAL[:stopbits]   || 1
parity        = SERIAL[:parity]     || 0
initstring    = SERIAL[:initstring] || "ATZ"

SerialPort.open(serial_device, baudrate, databits, stopbits, parity) do |s|

  puts "#{s.baud} [#{s.data_bits} #{s.parity} #{s.stop_bits}]"
  s.write "#{initstring}\r"

  while line = s.readline
    puts line
    next unless line =~ /^RING;\d+;\d+/
    cmd, callerid, msn = line.chomp.split(/;/)
    puts "Callerid: #{callerid}"

    system(action_url.gsub(/###callerid###/, callerid))
    
  end
end


