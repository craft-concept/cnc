# See: https://github.com/norman/friendly_id

$options ||= JSON.load(ENV['OPTIONS'] || '{}')

gem "friendly_id" unless match_file("Gemfile", /friendly_id/)

inject_into_class "app/models/application_record.rb", "ApplicationRecord" do
  "  extend FriendlyId\n"
end

migration = Dir["db/migrate/*"].none?(/friendly_id/)
initializer = Dir["config/initializers/*"].none?(/friendly_id/)

after_bundle do
  generate "friendly_id", *("--skip-migration" unless migration),
                          *("--skip-initializer" unless initializer)

  if initializer
    uncomment_lines "config/initializers/friendly_id.rb", "config.use :"
  end

  rails_command "db:migrate" if !$options["skip_migrate"] && migration
end
