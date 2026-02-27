module CNC
  module CLI
    class Add < Command
      namespace "cnc:add"

      desc "search", "Add pg_search"
      options skip_migrate: false, skip_multi: false
      def search
        raise "Can only add search when using postgres" unless pg?
        template "pg_search"
      end

      desc "slugs", "Add friendly_id"
      options skip_migrate: true
      def slugs
        template "friendly_id"
      end

      desc "versions", "Add paper_trail version tracking"
      options skip_migrate: true
      def versions
        template "paper_trail"
      end

      def method_missing(name, ...)
        puts "Not found. Falling back to running the template..."
        template name
      end

      private

      def template(path)
        template = CNC.root("templates", path).sub_ext(".rb").to_s
        run "rails app:template LOCATION='#{template}' OPTIONS='#{options.to_json}'"

        # TODO: Run app:template in process:
        # require File.expand_path("config/application", Dir.pwd)
        # require "cnc/rails/app_generator"

        # $options = options
        #
        # puts template
        # CNC::Rails::AppGenerator.apply_rails_template(template, Dir.pwd)
      end
    end
  end
end
