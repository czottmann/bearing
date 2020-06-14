#!/usr/bin/ruby

require_relative 'src/methods.rb'

if !ARGV[0]
  print_menu_items
elsif ARGV[0].start_with?('bearing://')
  write_incoming_data_to_tmp_file(ARGV[0])
elsif ARGV[0].start_with?('Install')
  create_shell_integration
elsif ARGV[0].start_with?('Uninstall')
  remove_shell_integration
end
