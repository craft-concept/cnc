require "listen"

module CNC
  module Migrator
    module_function

    def logger
      @logger ||= ActiveSupport::TaggedLogging.new(Rails.logger).tagged("CNC::Migrator")
    end

    def log(...) = logger.info(...)

    def path = Rails.root / "db"
    def only = %r{(migrate/)([a-z]\w+)\.rb$}

    def fresh_migration(name)
      <<~RUBY
        class #{name.camelize} < ActiveRecord::Migration[#{ActiveRecord::Migration.current_version}]
          def change
            #{yield if block_given?}
          end
        end
      RUBY
    end

    def process(paths)
      number = Time.now.utc.strftime("%Y%m%d%H%M%S")
      paths.each do |path|
        body = File.read(path)
        new_path = path.sub(only, "\\1#{number}_\\2.rb")
        log "Moving '#{path}' to '#{new_path}'."

        File.rename(path, new_path)
        File.open(new_path, "w+") do |file|
          file << fresh_migration($2)  { body }
        end
        number.succ!
      end
    end

    def listen
      log "Watching for unstamped migration files in #{path}."
      Listen.to(path, only:, relative: true) do |modified, added, removed|
        process(added | modified)
      end.start
    rescue Errno::ENOENT
      log "db/ directory does not exist."
    end
  end
end
