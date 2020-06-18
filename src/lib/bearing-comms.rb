# frozen_string_literal: true

require 'cgi'
require 'fileutils'
require 'json'
require 'timeout'
require 'uri'

require_relative '../config.rb'

module Bearing
  module Comms
    class << self
      def query_to_json(query_str = '', success: false)
        res = Hash[
          CGI::parse(query_str).map do |k, v|
            new_v = JSON.parse(v[0]) rescue v[0]
            [k, new_v]
          end
        ]
        res[:_success] = success
        res.to_json
      end

      def remove_tmp_folder(call_id = '')
        FileUtils.remove_dir(unique_tmp_folder(call_id))
      end

      def unique_tmp_file(call_id = '')
        unique_tmp_folder(call_id) + '/result.json'
      end

      def unique_tmp_folder(call_id = '')
        tmp_path = "/tmp/#{::APP_BUNDLE_ID}/#{call_id}"
        FileUtils.mkdir_p(tmp_path, mode: 0700) unless Dir.exist?(tmp_path)
        tmp_path
      end

      def wait_for_incoming_data(call_id = '')
        results = begin
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

                    res
                  rescue Timeout::Error
                    ({ _success: false, _timeout: true }).to_json
                  end

        remove_tmp_folder(call_id)
        results
      end

      def write_incoming_data_to_tmp_file(uri_string = '')
        uri = URI.parse(uri_string)
        call_id = uri.host
        is_success = (uri.path == '/success')
        tmp_filename = unique_tmp_file(call_id)
        output = query_to_json(uri.query, success: is_success)

        File.open(tmp_filename, 'w') { |f| f.puts output }
      end
    end
  end
end
