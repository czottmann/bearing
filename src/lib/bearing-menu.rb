# frozen_string_literal: true

require_relative '../config.rb'

module Bearing
  module Menu
    class << self
      def print_items
        option = File.exist?(::SHELL_INTEGRATION_PATH) ? 'Uninstall' : 'Install'

        puts <<~EOTXT
          DISABLED|Bearing, a scripting helper for Bear.
          DISABLED|Made with ❤️ in Munich in 2020
          DISABLED|by Carlo Zottmann <carlo@zottmann.org>
          ----
          #{option} #{::SHELL_INTEGRATION_PATH}
          ----
          DISABLED|Let's be excellent to eachother
        EOTXT
      end
    end
  end
end
