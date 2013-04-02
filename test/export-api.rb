require 'test/unit'

class Test::Unit::TestCase
  def test
    require 'pegex'
    assert method('pegex'),
      'pegex is exported'

    parser1 = pegex "foo: <bar>\n"

    assert parser1.kind_of?(Pegex::Parser),
      'pegex returns a Pegex::Parser object'

    assert_equal parser1.grammar.tree['+toprule'], 'foo',
      'pegex() contains a grammar with a compiled tree'

    parser2 = pegex(<<'...');
number: /<DIGIT>+/
...

    begin
      parser2.parse '123'
      assert true, 'parser2.parse worked'
    rescue
      assert false, "parser2.parse failed: #{$!.message}"
    end

    assert parser2.kind_of?(Pegex::Parser),
      'grammar property is Pegex::Parser object'

    tree2 = parser2.grammar.tree
    assert tree2, 'Grammar object has tree';
    assert tree2.kind_of?(Hash), 'Grammar object is compiled to a tree'

    assert_equal tree2['+toprule'], 'number',
      '_FIRST_RULE is set correctly'
  end
end
