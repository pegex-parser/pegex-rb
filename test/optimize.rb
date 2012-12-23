require './test/lib/test_pegex'

__END__
#TODO
TestML.require_or_skip 'psych'

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