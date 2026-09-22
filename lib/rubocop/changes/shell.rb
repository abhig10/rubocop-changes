# frozen_string_literal: true

module Rubocop
  module Changes
    class Shell
      def self.run(command)
        output = `#{command}`
        sanitize_output(output).strip
      end

      def self.sanitize_output(output)
        output
          .dup
          .force_encoding(Encoding::BINARY)
          .encode(Encoding::UTF_8, invalid: :replace, undef: :replace, replace: '')
      end
    end
  end
end
