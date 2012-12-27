puts "TODO";exit
require 'testml/lite'
require 'test_pegex'

TestML::Test.new

__END__
#TODO
TestML.run do |t|
  t.eval '*grammar.compile.optimize.yaml.clean == *yaml'
end

TestML.data <<'...'
=== Question Mark Expansion
--- grammar
a: /(:foo)/
--- yaml
a:
  .rgx: /(?:foo)/
...
