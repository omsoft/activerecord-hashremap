# frozen_string_literal: true

require_relative "lib/acts_as_remappable/version"

Gem::Specification.new do |spec|
  spec.name = "acts_as_remappable"
  spec.version = ActsAsRemappable::VERSION
  spec.authors = ["Mattia Orfano"]
  spec.email = ["info@mattiaorfano.com"]

  # rubocop:disable Layout/LineLength

  spec.summary = "Recursively collect deeply nested keys/values pairs and remap them to the attributes of your model"
  spec.description = "ActsAsRemappable is a Hash deserializer and ActiveRecord mapper to promote attributes into the database using a recursive algorithm."
  spec.homepage = "https://github.com/omsoft/acts_as_remappable"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/omsoft/acts_as_remappable"
  spec.metadata["changelog_uri"] = "https://github.com/omsoft/acts_as_remappable/blob/master/CHANGELOG.md"

  # rubocop:enable Layout/LineLength

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # The following development dependencies will be listed on the gem's details page on rubygems.org,
  # thus helping other developers what will be required if they want to contribute to the gem.
  # Another benefit of putting this specification here rather than the Gemfile is that anybody who
  # runs gem install activerecord-hashremap --dev will get these development dependencies installed too.
  spec.add_development_dependency "rspec", "~> 3.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
