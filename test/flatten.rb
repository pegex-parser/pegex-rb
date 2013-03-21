require 'test/unit'
require 'pegex'
require 'pegex/receiver'

class TestFlatten < Test::Unit::TestCase
  def test_flatten
    grammar = <<'...'
a: (((b)))+
b: (c | d)
c: /(x)/
d: /y/
...
    parser = pegex(grammar, R)
    got = parser.parse('xxx')

    assert_equal got.join(''), 'xxx', 'Array was flattened'
  end
end

class R < Pegex::Receiver
  def got_a(got)
    got.flatten
  end
  def got_b(got)
    [got]
  end
  def got_c(got)
    [got]
  end
end
