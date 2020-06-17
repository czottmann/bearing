#!/usr/bin/ruby

require_relative 'src/config.rb'
require_relative 'src/lib/bearing-comms.rb'
require_relative 'src/lib/bearing-menu.rb'
require_relative 'src/lib/bearing-shell-integration.rb'

incoming = ARGV[0]

if !incoming
  Bearing::Menu.print_items

elsif incoming.start_with?(::URI_SCHEME)
  Bearing::Comms.write_incoming_data_to_tmp_file(incoming)

elsif incoming.start_with?('Install')
  Bearing::ShellIntegration.install

elsif incoming.start_with?('Uninstall')
  Bearing::ShellIntegration.uninstall
end
