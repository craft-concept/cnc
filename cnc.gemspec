require_relative "lib/cnc/version"

Gem::Specification.new do |spec|
  spec.name        = "cnc"
  spec.version     = CNC::VERSION
  spec.authors     = ["Jeff Peterson"]
  spec.email       = ["jeff@concept.love"]
  spec.homepage    = "https://github.com/craft-concept/cnc"
  spec.summary     = "Rails starter kit."
  spec.description = "Stop milling about and build rails apps faster with CNC."
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/craft-concept/cnc"
  spec.metadata["changelog_uri"] = "https://github.com/craft-concept/cnc"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib,exe}/**/*", "MIT-LICENSE", "Rakefile", "README.md", ".rubocop.yml"]
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { File.basename(_1) }

  spec.add_dependency "rubocop-rails-omakase"
  spec.add_dependency "rails"
  spec.add_dependency "dry-cli"
end
