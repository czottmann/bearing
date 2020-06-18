# frozen_string_literal: true

require 'uri'

module Bearing
  module IncomingURICall
    class << self
      def handle(uri_string = '')
        comms = Bearing::Comms.new(call_id: URI.parse(uri_string).host)
        comms.write_incoming_data_to_tmp_file(uri_string)
      end
    end
  end
end
