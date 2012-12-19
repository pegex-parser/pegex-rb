# encoding: utf-8

GemSpec = Gem::Specification.new do |gem|
  gem.name = 'pegex'
  gem.version = '0.0.1'
  gem.license = 'MIT'
  gem.required_ruby_version = '>= 1.9.1'

  gem.authors << 'Ingy döt Net'
  gem.email = 'ingy@ingy.net'
  gem.summary = 'Acmeist PEG Parsing Framework'
  gem.description = <<-'.'
Pegex is a Acmeist parser framework. It allows you to easily create parsers
that will work equivalently in lots of programming languages!
.
  gem.homepage = 'http://pegex.org'

  gem.files = `git ls-files`.lines.map{|l|l.chomp}
end
