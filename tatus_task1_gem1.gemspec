
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "tatus_task1_gem1/version"

Gem::Specification.new do |spec|
  spec.name          = "tatus_task1_gem1"
  spec.version       = TatusTask1Gem1::VERSION
  spec.authors       = ["Tetiana Usova"]
  spec.email         = ["tataruty@outlook.com"]

  spec.summary       = %q{task1 for KitmanLabs}
  spec.description   = %q{a long description}
  spec.homepage      = "https://github.com/tataruty/tatus_task1_gem1.git"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    #spec.metadata["allowed_push_host"] = "TODO: Set to '..'"

    spec.metadata["homepage_uri"] = "https://github.com/tataruty/tatus_task1_gem1.git"
    spec.metadata["source_code_uri"] = "https://github.com/tataruty/tatus_task1_gem1.git"
    spec.metadata["changelog_uri"] = "https://github.com/tataruty/tatus_task1_gem1.git"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1.4"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "faraday"
end
