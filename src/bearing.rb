#!/usr/bin/ruby

require 'securerandom'
require './methods.rb'

AVAILABLE_ACTIONS = %w(
  open-note create add-text add-file tags open-tag rename-tag delete-tag trash
  archive untagged todo today locked search grab-url change-theme change-font
)

call_id = SecureRandom.uuid
# tmp_folder = unique_tmp_folder(call_id)

action, *args = ARGV

validate_action!(action)
params = translate_args_to_hash(args)

p action
p params

call_bear(action: action, call_id: call_id, params: params)

# clean_up_tmp(call_id)
