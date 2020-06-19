#!/usr/bin/ruby

require_relative 'config'
require_relative 'lib/bearing-bear'
require_relative 'lib/bearing-cmd'
require_relative 'lib/bearing-ipc'

action, *args = ARGV
ipc = Bearing::IPC.new

Bearing::Cmd.validate_action_argument!(action)
Bearing::Cmd.start_app
Bearing::Bear.call_api(action: action, args: args, call_id: ipc.call_id)

puts ipc.wait_for_incoming_data
