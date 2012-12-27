puts "TODO";exit
require 'testml/lite'
require 'test_pegex'

testml = TestML::Test.new do |t|
  t.bridge = TestPegex
  t.tmlfile = 'test/compiler.tml'
end

TestML.run do |t|
  t.eval '*grammar', t.method('run_compiler_tests')
end

class TestPegex
  def run_compiler_tests block, expr=nil
    label '$BlockLabel - Compiler output matches bootstrap?'
    run_test(
      block,
      '*grammar.compile.yaml == *grammar.compile.yaml',
    )

    label '$BlockLabel - Compressed grammar compiles the same?'
    run_test(
      block,
      '*grammar.compress.compile.yaml == *grammar.compress.compile.yaml',
    )

    label '$BlockLabel - Compressed grammar matches uncompressed?'
    run_test(
      block,
      '*grammar.compress.compile.yaml == *grammar.compile.yaml',
    )
  end

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
