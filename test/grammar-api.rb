require 'testml'
require 'test_pegex'
require 'pegex/grammar'

TestML::Lite.new testml: <<'...'
Plan = 1
# Label = 'MyGrammar1 compiled a tree from its text'
grammar_api == 'foo'
...

class TestML::Lite::Library
  def grammar_api
    grammar = MyGrammar1.new
    grammar.make_tree
    grammar.tree['+toprule']
  end
end

class MyGrammar1 < Pegex::Grammar
  def initialize
    @text = <<'...'
foo: /xyz/ <bar>
bar:
    /abc/ |
    <baz>
baz: /def/
...
  end
end
