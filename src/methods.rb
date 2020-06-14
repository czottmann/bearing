# frozen_string_literal: true

require 'json'
require 'cgi'
require 'uri'
require 'fileutils'


def call_bear(action: '', call_id: '', params: {})
  uri = [
    'bear://x-callback-url/',
    action, '?',
    params_to_url_params(params), '&',
    'x-error=', CGI::escape("bearing://#{call_id}/error"), '&',
    'x-success=', CGI::escape("bearing://#{call_id}/success"),
  ].join('')

  system("open '#{uri}'")
end

def remove_tmp_folder(call_id = '')
  FileUtils.remove_dir(unique_tmp_folder(call_id))
end

def print_usage
  puts <<EOTXT
Usage: #{$0} ACTION [parameters]

      ACTION: The Bear action to call (e.g., 'open-note', 'create', 'add-text',
              etc.)"

      Parameters are passed in the form 'key=value', e.g. 'title="My new note"'.
      See https://bear.app/faq/X-callback-url%20Scheme%20documentation/ for
      parameters available.

Examples:

      #{$0} \\
        open-note \\
        --title="Some existing note" \\
        --exclude_trashed=yes

      #{$0} \\
        todo \\
        --exclude_trashed=yes \\
        --token=ABCDEF-123456-A1B2C3
EOTXT
end

def params_to_url_params(params = {})
  params.map do |k, v|
    next unless k && v
    CGI::escape(k) + '=' + CGI::escape(v)
  end.compact.join('&')
end

def query_to_json(query_str = '', success: false)
  res = Hash[
    CGI::parse(query_str).map {|k, v| [k, (JSON.parse(v[0]) rescue v[0])] }
  ]
  res[:_success] = success
  res.to_json
end

def translate_args_to_hash(args = [])
  Hash[args.flat_map {|s| s.scan(/^--([a-z_]+)=(.*)$/) }]
end

def unique_tmp_file(call_id = '')
  unique_tmp_folder(call_id) + '/result.json'
end

def unique_tmp_folder(call_id = '')
  tmp_path = "/tmp/org.zottmann.Bearing/#{call_id}"
  FileUtils.mkdir_p(tmp_path, mode: 0700) unless Dir.exist?(tmp_path)
  tmp_path
end

def validate_action_argument!(action = '')
  if !action || action == '--help'
    print_usage
    exit 0
  end

  return if AVAILABLE_ACTIONS.include?(action)

  actions_list = AVAILABLE_ACTIONS.sort.map {|a| "- #{a}"}.join("\n")
  puts <<EOTXT
ERROR: first argument (action) must be one of …

#{actions_list}

Call '#{$0} --help' for usage information
EOTXT
  exit 1
end
