require 'testml'
require 'testml/compiler/lite'
require 'testml/util'; include TestML::Util
require 'pegex/grammar'

TestML.new(
  compiler: TestML::Compiler::Lite,
).testml = <<'...'
%TestML 0.1.0
Plan = 1
# Label = 'MyGrammar1 compiled a tree from its text'
grammar_api() == 'foo'
...

class TestML::Bridge
  def grammar_api
    grammar = MyGrammar1.new
    grammar.make_tree
    native grammar.tree['+toprule']
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
