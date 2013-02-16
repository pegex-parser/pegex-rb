require 'testml'
require 'test_pegex'

TestML::Lite.new \
  bridge: TestPegex,
  testml: <<'...'
*grammar.compile.optimize.yaml.clean == *yaml

=== Question Mark Expansion
--- grammar
a: /(:foo)/
--- yaml
a:
  .rgx: /(?:foo)/
...
