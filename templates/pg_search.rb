# See: https://github.com/Casecommons/pg_search/

$options ||= JSON.load(ENV['OPTIONS'] || '{}')

gem "pg_search" unless match_file("Gemfile", /pg_search/)

inject_into_class "app/models/application_record.rb", "ApplicationRecord" do
  "  include PgSearch::Model\n"
end

unless $options["skip_multi"] or Dir["db/migrate/*"].any?(/pg_search/)
  after_bundle do
    generate "pg_search:migration:multisearch"
    rails_command "db:migrate" unless $options["skip_migrate"]
  end
end
