#!/usr/bin/ruby

require_relative 'config'
require_relative 'lib/bearing-cmd'
require_relative 'lib/bearing-ipc'

action, *args = ARGV
ipc = Bearing::IPC.new

Bearing::Cmd.start_app
Bearing::Cmd.validate_action_argument!(action)
Bearing::Cmd.call_bear(
  action: action,
  call_id: ipc.call_id,
  params: Bearing::Cmd.translate_args_to_hash(args),
)

puts ipc.wait_for_incoming_data
