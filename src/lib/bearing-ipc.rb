# frozen_string_literal: true

require 'fileutils'
require 'json'
require 'securerandom'
require 'timeout'
require 'uri'

require_relative '../config'

module Bearing
  class IPC
    attr_reader :call_id

    def initialize(call_id: SecureRandom.uuid)
      @call_id = call_id
    end

    def wait_for_incoming_data
      results =
        begin
          res = nil

          Timeout.timeout(3) do
            while !res
              if File.exist?(unique_tmp_file)
                res = File.read(unique_tmp_file)
              else
                sleep 0.4
              end
            end
          end

          res
        rescue Timeout::Error
          ({ _success: false, _timeout: true }).to_json
        end

      FileUtils.remove_dir(unique_tmp_folder)
      results
    end

    def write_incoming_data_to_tmp_file(uri_string = '')
      uri = URI.parse(uri_string)
      is_success = (uri.path == '/success')
      output = query_to_json(uri.query, success: is_success)

      File.open(unique_tmp_file, 'w') { |f| f.puts output }
    end

    private

    def query_to_json(query_str = '', success: false)
      res =
        Hash[
          CGI.parse(query_str).map do |k, v|
            new_v =
              begin
                JSON.parse(v[0])
              rescue StandardError
                v[0]
              end
            [k, new_v]
          end
        ]
      res[:_success] = success
      res.to_json
    end

    def unique_tmp_file
      "#{unique_tmp_folder}/result.json"
    end

    def unique_tmp_folder
      tmp_path = "/tmp/#{::APP_BUNDLE_ID}/#{@call_id}"
      FileUtils.mkdir_p(tmp_path, mode: 0o700) unless Dir.exist?(tmp_path)
      tmp_path
    end
  end
end
