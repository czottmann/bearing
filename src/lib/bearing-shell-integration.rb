# frozen_string_literal: true

require 'fileutils'

require_relative '../config.rb'

module Bearing
  module ShellIntegration
    class << self
      def install
        orig = File.expand_path(File.dirname(__FILE__) + '/../cli.rb')
        FileUtils.ln_s(orig, ::SHELL_INTEGRATION_PATH)
      end

      def uninstall
        FileUtils.remove(::SHELL_INTEGRATION_PATH)
      end
    end
  end
end
