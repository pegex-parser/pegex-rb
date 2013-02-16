require 'testml'
require 'test_pegex'

TestML::Lite.new \
  bridge: TestPegex,
  data: 'compiler.tml',
  testml: <<'...'
Plan = 63

Label = '$BlockLabel - Compiler output matches bootstrap?'
*grammar.pegex_compile.yaml == *grammar.bootstrap_compile.yaml

Label = '$BlockLabel - Compressed grammar compiles the same?'
*grammar.compress.compile.yaml == *grammar.compress.compile.yaml

Label = '$BlockLabel - Compressed grammar matches uncompressed?'
*grammar.compress.compile.yaml == *grammar.compile.yaml
...

class TestPegex
  def compress grammar_text
    grammar_text.gsub! /([^;])\n(\w+\s*:)/ do |m|
      "#{$1};#{$2}"
    end
    grammar_text.gsub! /\s/, ''

    # XXX mod/quant ERROR rules are too prtective here:
    grammar_text.gsub! />%</, '> % <'
    return "#{grammar_text}\n"
  end
end
