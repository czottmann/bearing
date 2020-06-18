# frozen_string_literal: true

require 'cgi'

require_relative '../config'

module Bearing
  module Cmd
    class << self
      def call_bear(action: '', call_id: '', params: {})
        query =
          [
            params_to_url_query(params),
            'x-error=' + CGI.escape("#{::URI_SCHEME}#{call_id}/error"),
            'x-success=' + CGI.escape("#{::URI_SCHEME}#{call_id}/success"),
          ].join('&')
        uri = ['bear://x-callback-url/', action, '?', query].join('')

        system("open '#{uri}'")
      end

      def params_to_url_query(params = {})
        params.map do |k, v|
          next unless k && v
          CGI.escape(k) + '=' + CGI.escape(v)
        end.compact.join('&')
      end

      def print_usage
        puts <<EOTXT
Usage: #{
          $0
        } ACTION [parameters]

      ACTION: The Bear action to call (e.g., 'open-note', 'create', 'add-text',
              etc.)"

      Parameters are passed in the form 'key=value', e.g. 'title="My new note"'.
      See https://bear.app/faq/X-callback-url%20Scheme%20documentation/ for
      parameters available.

Examples:

      #{
          $0
        } \\
        open-note \\
        --title="Some existing note" \\
        --exclude_trashed=yes

      #{
          $0
        } \\
        todo \\
        --exclude_trashed=yes \\
        --token=ABCDEF-123456-A1B2C3

Credits:

      Bearing, a scripting helper for Bear.  Version #{
          ::VERSION
        }.
      Made by Carlo Zottmann <carlo@zottmann.org>
      Home @ https://gitlab.com/czottmann/bearing
EOTXT
      end

      def start_app
        # Start the app bundle so the first call Bear doesn't time out
        system("open -b #{::APP_BUNDLE_ID}")
      end

      def translate_args_to_hash(args = [])
        Hash[args.flat_map { |s| s.scan(/^--([a-z_]+)=(.*)$/) }]
      end

      def validate_action_argument!(action = '')
        if !action || action == '--help'
          print_usage
          exit 0
        elsif ::AVAILABLE_BEAR_ACTIONS.include?(action)
          return
        end

        actions_list =
          ::AVAILABLE_BEAR_ACTIONS.sort.map { |a| "- #{a}" }.join("\n")

        puts <<~EOTXT
          ERROR: first argument (action) must be one of …

          #{
          actions_list
        }

          Call '#{$0} --help' for usage information
        EOTXT
        exit 1
      end
    end
  end
end
