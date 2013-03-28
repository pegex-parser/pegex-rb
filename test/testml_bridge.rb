require 'testml/bridge'
require 'testml/util'; include TestML::Util
require 'pegex'
require 'pegex/compiler'
require 'pegex/tree'
require 'pegex/tree/wrap'
require 'testast'
require 'yaml'
# XXX can we eliminate this?
require 'recursive_sort'

class TestMLBridge < TestML::Bridge
  def compile grammar
    tree = Pegex::Compiler.new.parse(grammar.value).combinate.tree
    tree.delete '+toprule'
    return native tree
  end

  alias bootstrap_compile compile

  def compress grammar
    grammar = grammar.value
    grammar.gsub! /([^;])\n(\w+\s*:)/, '\1;\2'
    grammar.gsub! /\s/, ''

    # XXX mod/quant ERROR rules are too protective here:
    grammar.gsub! />%</, '> % <'

    return str "#{grammar}\n"
  end

  def yaml object
    return str YAML.dump(object.value.recursive_sort)
  end

  def clean yaml
    yaml = yaml.value
    yaml.sub! /^\.\.\.\n/, ''
    yaml.sub! /\A---\s/, ''
    yaml.gsub! /'(\d+)'/, '\1'
    yaml.gsub! /\+eok: true/, '+eok: 1'
    return str yaml
  end

  def parse_input grammar, input
    parser = pegex(grammar.value)
    return native parser.parse input.value
  end

  def parse_to_tree(grammar, input)
    parser = pegex(grammar.value, Pegex::Tree)
    return native parser.parse(input.value)
  end

  def parse_to_tree_wrap(grammar, input)
    parser = pegex(grammar.value, Pegex::Tree::Wrap)
    return native parser.parse(input.value)
  end

  def parse_to_tree_test(grammar, input)
    parser = pegex(grammar.value, TestAST)
    return native parser.parse(input.value)
  end
end
