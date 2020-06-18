#!/usr/bin/ruby

require_relative 'config.rb'
require_relative 'lib/bearing-cmd.rb'
require_relative 'lib/bearing-comms.rb'

action, *args = ARGV
comms = Bearing::Comms.new

Bearing::Cmd.start_app
Bearing::Cmd.validate_action_argument!(action)
Bearing::Cmd.call_bear(
  action: action,
  call_id: comms.call_id,
  params: Bearing::Cmd.translate_args_to_hash(args),
)

puts comms.wait_for_incoming_data
