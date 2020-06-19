# frozen_string_literal: true

require 'uri'

require_relative 'ipc'

module Bearing
  module IncomingURICall
    class << self
      def handle(uri_string = '')
        call_id = URI.parse(uri_string).host
        ipc = Bearing::IPC.new(call_id: call_id)
        ipc.write_incoming_data_to_tmp_file(uri_string)
      end
    end
  end
end
