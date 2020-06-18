# frozen_string_literal: true

require 'uri'

require_relative '../config'
require_relative 'bearing-incoming-uri-call'
require_relative 'bearing-shell-integration'

module Bearing
  module Routing
    class << self
      def handle(arg = '')
        if arg.start_with?(::URI_SCHEME)
          Bearing::IncomingURICall.handle(arg)
        elsif arg.start_with?('Install')
          Bearing::ShellIntegration.install
        elsif arg.start_with?('Uninstall')
          Bearing::ShellIntegration.uninstall
        end
      end
    end
  end
end
