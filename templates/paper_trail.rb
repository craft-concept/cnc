# See: https://github.com/paper-trail-gem/paper_trail

$options ||= JSON.load(ENV['OPTIONS'] || '{}')

gem "paper_trail" unless match_file("Gemfile", /paper_trail['"]/)
gem "paper_trail-association_tracking" unless match_file("Gemfile", "paper_trail-association_tracking")

inject_into_class "app/controllers/application_controller.rb", "ApplicationController" do
  "  before_action :set_paper_trail_whodunnit\n"
end

inject_into_class "app/models/application_record.rb", "ApplicationRecord" do
  "  # has_paper_trail\n"
end

unless Dir["db/migrate/*"].any?(/create_versions/)
  after_bundle do
    generate "paper_trail:install --with-changes"
    generate "paper_trail_association_tracking:install"
    rails_command "db:migrate" unless $options["skip_migrate"]
  end
end
