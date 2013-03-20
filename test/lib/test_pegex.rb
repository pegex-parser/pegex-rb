require 'pegex/compiler'
require 'recursive_sort'

require 'pegex/tree'
require 'pegex/tree/wrap'
require 'testast'

class TestPegex < TestML::Lite::Bridge
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
    return yaml
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
