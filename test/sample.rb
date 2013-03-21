require 'test/unit'
require 'pegex/grammar'
require 'pegex/compiler'

class TestSample < Test::Unit::TestCase
  def test_sample
    grammar_text = <<'...'
contact:
    name_section
    phone_section
    address_section

name_section:
    / Name <COLON> <BLANK>+ /
    name
    EOL

name: /(<WORD>+)<BLANK>(<WORD>+)/

phone_section: /Phone<COLON><BLANK>+/ <phone_number> <EOL>
phone_number: term

address_section:
    /Address<COLON><EOL>/
    street_line
    city_line
    country_line?

street_line: indent street EOL
street: /<NS><ANY>*/
city_line: indent city EOL
city: term
country_line: indent country EOL
country: term

term: /(
    <NS>            # NS is "non-space"
    <ANY>*
)/

indent: /<BLANK>{2}/
...

    input = <<'...'
Name: Ingy Net
Phone: 919-876-5432
Address:
  1234 Main St
  Niceville
  OK
...

    want = <<'...'
...

    grammar = Pegex::Grammar.new do |i|
      i.tree = Pegex::Compiler.new.compile(grammar_text).tree
    end
    parser = Pegex::Parser.new do |i|
      i.grammar = grammar
      # XXX next line not in Perl test
      i.receiver = Pegex::Receiver.new
    end
    ast1 = parser.parse(input)

    assert true, 'parsed'
# TODO
#     got = YAML.dump(ast1)
#     assert_equal got, want, 'It works'
  end
end

