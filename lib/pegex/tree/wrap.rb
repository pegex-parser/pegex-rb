require 'pegex/tree'

class Pegex::Tree::Wrap < Pegex::Tree
  def gotrule got
    return got || Pegex::Constant::Null if @parser.parent['-pass']
    return Pegex::Constant::Null unless got
    return @parser.rule => got
  end

  def final got
    return got || {@parser.rule => []}
  end
end
