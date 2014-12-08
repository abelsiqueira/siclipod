#coding utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'siclipod/version'

Gem::Specification.new do |spec|
  spec.name         = 'siclipod'
  spec.version      = Siclipod::VERSION
  spec.author       = ["Abel Soares Siqueira"]
  spec.email        = ["abel.s.siqueira@gmail.com"]
  spec.summary      = "SiCLIPoD"
  spec.description  = "Simple CLI Podcast Downloader"
  spec.homepage     = "http://github.com/abelsiqueira/siclipod"
  spec.license      = "GPLv3"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "nokogiri", "~> 1.6"
end
