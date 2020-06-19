#!/usr/bin/ruby

require_relative 'src/config'
require_relative 'src/bearing/menu'
require_relative 'src/bearing/routing'

ARGV[0] ? Bearing::Routing.handle(ARGV[0]) : Bearing::Menu.print_items
