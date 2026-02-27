module CNC
  module CLI
    class Command < Thor
      include Thor::Actions

      namespace "cnc"

      private

      def self.exit_on_failure? = true

      # TODO
      def pg? = adapter.pg?
      alias postgres? pg?

      def adapter
        @adapter ||= ActiveSupport::StringInquirer.new("pg")
      end
    end
  end
end
