require 'test/unit'
require 'pegex'
require 'pegex/input'

class TestParse < Test::Unit::TestCase
  def test_parse
    grammar_file = 'test/mice.pgx';
    # XXX need to add file support to Pegex::Input
    # input =  Pegex::Input.new(file: grammar_file)
    input = File.read(grammar_file)
    begin
      pegex(input).parse("3 blind mice\n")
      assert true, "!<rule> works"
    rescue
      assert false, "!<rule> fails"
    end
  end
end
