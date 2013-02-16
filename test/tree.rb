require 'testml'

require 'pegex/tree'
require 'pegex/tree/wrap'
require 'testast'

TestML::Lite.new testml: <<'...'
Plan = 1

Data = Compile('tree.tml')
Label = '$BlockLabel - Pegex::Tree'
parse_to_tree('Pegex::Tree', *grammar, *input).yaml.clean == *tree
Label = '$BlockLabel - Pegex::Tree::Wrap'
parse_to_tree('Pegex::Tree::Wrap', *grammar, *input).yaml.clean == *wrap
Label = '$BlockLabel - t::TestAST'
parse_to_tree('TestAST', *grammar, *input).yaml.clean == *ast

Data = Compile('tree-pegex.tml')
Label = '$BlockLabel - Pegex::Tree'
parse_to_tree('Pegex::Tree', *grammar, *input).yaml.clean == *tree
Label = '$BlockLabel - Pegex::Tree::Wrap'
parse_to_tree('Pegex::Tree::Wrap', *grammar, *input).yaml.clean == *wrap
Label = '$BlockLabel - TestAST'
parse_to_tree('TestAST', *grammar, *input).yaml.clean == *ast
...

class TestML::Lite::Bridge
  require 'pegex'
  def parse_to_tree(receiver, grammar, input)
    require receiver.downcase.gsub /::/, '/'
    parser = pegex(grammar, Kernel.eval(receiver))
    return parser.parse(input)
  end
end
