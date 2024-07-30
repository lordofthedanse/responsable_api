# frozen_string_literal: true

require_relative "lib/responsable_api/version"

Gem::Specification.new do |spec|
  spec.name = "responsable_api"
  spec.version = ResponsableAPI::VERSION
  spec.authors = ["Dan Brown"]
  spec.email = ["dbrown14@gmail.com"]

  spec.summary = "API conventions with reasonable response formats."
  spec.description   = "Provides a set of helper methods for consistent and standardized API responses, including success and error handling."
  spec.homepage      = "https://github.com/lordofthedanse/responsable_api"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ spec/ .git])
    end
  end
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "rails", "~> 7.0"
  spec.add_dependency "cancancan", "~> 3.5.0"
  spec.add_development_dependency "rspec", "~> 3.12.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
