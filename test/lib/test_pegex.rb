require 'pegex/compiler'
require 'recursive_sort'

class TestPegex < TestML::Bridge
  def compile grammar_text
    $grammar_text = grammar_text
    tree = Pegex::Compiler.new.parse(grammar_text).combinate.tree
    tree.delete '+toprule'
    return tree
  end

  def yaml object
    require 'yaml'
    YAML.dump object.recursive_sort
  end

  def clean yaml
    yaml.sub! /^\.\.\.\n/, ''
    yaml.sub! /\A---\s/, ''
    yaml.gsub! /'(\d+)'/, '\1'
    yaml.gsub! /\+eok: true/, '+eok: 1'
    return yaml
  end

  def on_fail
    puts "Parsing this Pegex grammar:"
    puts $grammar_text
    puts
  end
end
