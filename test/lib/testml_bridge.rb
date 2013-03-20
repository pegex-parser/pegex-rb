require 'testml/bridge'

require 'recursive_sort'
require 'pegex/compiler'
require 'pegex/tree'
require 'pegex/tree/wrap'
require 'testast'

require 'testml/util'
include TestML::Util

class TestMLBridge < TestML::Bridge
  def compile grammar_text
    tree = Pegex::Compiler.new.parse(grammar_text.value).combinate.tree
    tree.delete '+toprule'
    return tree
  end

  alias pegex_compile compile
  alias bootstrap_compile compile

  def yaml object
    object = object.value if object.kind_of? TestML::Str
    require 'yaml'
    YAML.dump object.recursive_sort
  end

  def clean yaml
    yaml = yaml.value
    yaml.sub! /^\.\.\.\n/, ''
    yaml.sub! /\A---\s/, ''
    yaml.gsub! /'(\d+)'/, '\1'
    yaml.gsub! /\+eok: true/, '+eok: 1'
    return str yaml
  end

  def compress grammar_text
    grammar_text = grammar_text.value
    grammar_text.gsub! /([^;])\n(\w+\s*:)/ do |m|
      "#{$1};#{$2}"
    end
    grammar_text.gsub! /\s/, ''

    # XXX mod/quant ERROR rules are too prtective here:
    grammar_text.gsub! />%</, '> % <'
    return str "#{grammar_text}\n"
  end

  def parse_input grammar, input
    parser = pegex grammar.value
    return parser.parse input.value
  end

  def optimize tree
    return tree
  end

  def on_fail
    puts "Parsing this Pegex grammar:"
    puts $grammar_text
    puts
  end

  def parse_to_tree(grammar, input)
    parser = pegex(grammar.value, Pegex::Tree)
    return parser.parse(input.value)
  end

  def parse_to_tree_wrap(grammar, input)
    parser = pegex(grammar.value, Pegex::Tree::Wrap)
    return parser.parse(input.value)
  end

  def parse_to_tree_test(grammar, input)
    parser = pegex(grammar.value, TestAST)
    return parser.parse(input.value)
  end
end
