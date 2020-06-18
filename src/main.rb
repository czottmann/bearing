#!/usr/bin/ruby

require_relative 'src/config'
require_relative 'src/lib/bearing-incoming-uri-call'
require_relative 'src/lib/bearing-ipc'
require_relative 'src/lib/bearing-menu'
require_relative 'src/lib/bearing-shell-integration'

arg = ARGV[0]

if !arg
  Bearing::Menu.print_items
elsif arg.start_with?(::URI_SCHEME)
  Bearing::IncomingURICall.handle(arg)
elsif arg.start_with?('Install')
  Bearing::ShellIntegration.install
elsif arg.start_with?('Uninstall')
  Bearing::ShellIntegration.uninstall
end
