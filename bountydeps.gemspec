module DependencyEvaluator
  def load_dependencies(path)
    instance_eval File.read(path)
  end
  
  def gem(*args)
    add_dependency(*args)
  end
end

Gem::Specification.new do |gem|
  gem.authors       = ["radiospiel"]
  gem.email         = ["eno@open-lab.org"]
  gem.description   = %q{Bountyhill dependency tracker}
  gem.summary       = gem.description
  gem.homepage      = ""

  # Read dependencies from Dependencies file.
  gem.extend DependencyEvaluator
  gem.load_dependencies "Dependencies"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "bountydeps"
  gem.require_paths = ["lib"]
  gem.version       = Time.now.strftime "%Y\.%m\.%d%H" 
end
