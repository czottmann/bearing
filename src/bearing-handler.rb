#!/usr/bin/ruby

require_relative 'src/methods.rb'

uri = URI.parse(ARGV[0])
call_id = uri.host
is_success = (uri.path == '/success')

tmp_filename = unique_tmp_file(call_id)
output = query_to_json(uri.query, success: is_success)

File.open(tmp_filename, 'w') { |f| f.puts output }
