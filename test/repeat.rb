require 'test/unit'
require 'pegex'

class TestRepeat < Test::Unit::TestCase
  def test_repeat
    parser = pegex('a: /<ANY>*?(x+)<ANY>*/')
    assert_equal parser.parse('xxxx')['a'], 'xxxx', 'First parse works'
    assert_equal parser.parse('xxxx')['a'], 'xxxx', 'Second parse works'
  end
end
