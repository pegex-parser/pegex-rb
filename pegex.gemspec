# encoding: utf-8

$gemspec = Gem::Specification.new do |gem|
  gem.name = 'pegex'
  gem.version = '0.0.1'
  gem.license = 'MIT'

  gem.authors << 'Ingy döt Net'
  gem.email = 'ingy@ingy.net'
  gem.summary = 'Acmeist PEG Parsing Framework'
  gem.description = <<-'.'
Pegex is a Acmeist parser framework. It allows you to easily create parsers
that will work equivalently in lots of programming languages!
.
  gem.homepage = 'http://pegex.org'

  gem.files = Dir.glob(%w(
    bin/*
    lib/**/*
    test/**/*

    *.gemspec
    Gemfile
    Rakefile
    CHANGELOG*
    LICENSE*
    README*
  ))
end
