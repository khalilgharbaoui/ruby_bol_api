# frozen_string_literal: true

require_relative "lib/ruby_bol_api/version"

Gem::Specification.new do |spec|
  spec.name = "ruby_bol_api"
  spec.version = RubyBolAPI::VERSION
  spec.authors = ["Khalil Gharbaoui"]
  spec.email = ["kaygeee@gmail.com"]

  spec.summary = "A Ruby bol.com API wrapper gem"
  spec.description = "A Ruby wrapper gem build around the bol.com API"
  spec.homepage = "https://github.com/khalilgharbaoui/ruby_bol_api#rubybolapi"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/khalilgharbaoui/ruby_bol_api"
  spec.metadata["changelog_uri"] = "https://github.com/khalilgharbaoui/ruby_bol_api/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "base64"
  spec.add_dependency "zache"
  spec.add_dependency "faraday"
  spec.add_dependency "faraday-retry"
  spec.add_dependency "faraday-follow_redirects"
  spec.add_dependency "logger"

  spec.add_development_dependency "pry"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
