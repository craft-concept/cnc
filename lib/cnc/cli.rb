require "thor"

module CNC
  module CLI
    def self.start(...) = Root.start(...)

    class Root < Command
      namespace :cnc

      desc "version", "Print version"
      def version = puts VERSION

      desc "add FEATURE", "Add a feature"
      subcommand "add", Add
    end
  end
end
