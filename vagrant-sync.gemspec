# -*- encoding: utf-8 -*-
Gem::Specification.new do |gem|
  gem.authors       = ["David Calavera"]
  gem.email         = ["david.calavera@gmail.com"]
  gem.description   = %q{rsync for Vagrant}
  gem.summary       = %q{rsync for Vagrant}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "vagrant-sync"
  gem.require_paths = ["lib"]
  gem.version       = '0.1.0'

  gem.add_runtime_dependency 'vagrant'
end
