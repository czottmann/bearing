# frozen_string_literal: true

require 'erb'

require_relative '../config'

module Bearing
  module Bear
    class << self
      include ERB::Util

      def call_api(action: '', args: [], call_id: '')
        response_base = "#{::URI_SCHEME}://#{call_id}"
        query =
          [
            args_to_url_query(args),
            'x-error=' + url_encode(response_base + '/error'),
            'x-success=' + url_encode(response_base + '/success'),
          ].join('&')

        system("open 'bear://x-callback-url/#{action}?#{query}'")
      end

      private

      def args_to_url_query(args = [])
        # Split `--x=y` CLI arguments into KV pairs
        pairs = Hash[args.flat_map { |s| s.scan(/^--([a-z_]+)=(.*)$/) }]

        # Turn KV pairs into query parameters
        pairs.map do |k, v|
          next unless k && v
          url_encode(k) + '=' + url_encode(v)
        end.compact.join('&')
      end
    end
  end
end
