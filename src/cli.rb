#!/usr/bin/ruby

require 'securerandom'
require 'timeout'

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
  params: Bearing::Cmd.translate_args_to_hash(args)
)

json_data = nil

begin
  res = nil
  tmp_filename = Bearing::Comms.unique_tmp_file(call_id)

  Timeout::timeout(3) do
    while !res do
      if File.exist?(tmp_filename)
        res = File.read(tmp_filename)
      else
        sleep 0.4
      end
    end
  end

  json_data = res
rescue Timeout::Error
  json_data = ({ _success: false, _timeout: true }).to_json
end

Bearing::Comms.remove_tmp_folder(call_id)

puts json_data
