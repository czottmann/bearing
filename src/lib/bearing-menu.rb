# frozen_string_literal: true

require_relative '../config'

module Bearing
  module Menu
    class << self
      def print_items
        verb = File.exist?(::SHELL_INTEGRATION_PATH) ? 'Uninstall' : 'Install'
        menu_entry = "#{verb} #{::SHELL_INTEGRATION_PATH}"

        puts [
               'DISABLED|Bearing, a scripting helper for Bear.',
               'DISABLED|Made with ❤️ in Munich in 2020',
               'DISABLED|by Carlo Zottmann <carlo@zottmann.org>',
               '----',
               menu_entry,
               '----',
               "DISABLED|Let's be excellent to eachother :)",
             ].join("\n")
      end
    end
  end
end
