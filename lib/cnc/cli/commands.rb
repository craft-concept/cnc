# frozen_string_literal: true

module CNC
  module CLI
    module Commands
      extend Dry::CLI::Registry

      class Command < Dry::CLI::Command; end

      class Version < Command
        desc "Print version"

        def call(*)
          puts VERSION
        end
      end

      register "version", Version, aliases: %w[v -v --version]
    end
  end
end
