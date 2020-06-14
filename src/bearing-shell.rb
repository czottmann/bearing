#!/usr/bin/ruby

require 'securerandom'
require 'timeout'
require_relative 'methods.rb'

AVAILABLE_ACTIONS = %w(
  open-note create add-text add-file tags open-tag rename-tag delete-tag trash
  archive untagged todo today locked search grab-url change-theme change-font
)

action, *args = ARGV
call_id = SecureRandom.uuid

validate_action_argument!(action)

call_bear(
  action: action,
  call_id: call_id,
  params: translate_args_to_hash(args)
)

json_data = nil

begin
  res = nil
  tmp_filename = unique_tmp_file(call_id)

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

remove_tmp_folder(call_id)

puts json_data
