#!/usr/bin/ruby

require_relative 'src/config'
require_relative 'src/lib/bearing-menu'
require_relative 'src/lib/bearing-routing'

ARGV[0] ? Bearing::Routing.handle(ARGV[0]) : Bearing::Menu.print_items
