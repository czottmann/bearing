#!/usr/bin/ruby

require 'securerandom'

require_relative 'config.rb'
require_relative 'lib/bearing-cmd.rb'
require_relative 'lib/bearing-comms.rb'

action, *args = ARGV
call_id = SecureRandom.uuid

Bearing::Cmd.validate_action_argument!(action)
Bearing::Cmd.start_app
Bearing::Cmd.call_bear(
  action: action,
  call_id: call_id,
  params: Bearing::Cmd.translate_args_to_hash(args),
)

puts Bearing::Comms.wait_for_incoming_data(call_id)
