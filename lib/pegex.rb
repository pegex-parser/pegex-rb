module Pegex;end

require 'pegex/parser'
require 'pegex/grammar'

def pegex grammar_text, receiver=nil
  unless receiver
    require 'pegex/tree/wrap'
    receiver = Pegex::Tree::Wrap.new
  end
  receiver = receiver.new \
    if receiver.class == Class
  return Pegex::Parser.new do |p|
    p.grammar = Pegex::Grammar.new {|g| g.text = grammar_text}
    p.receiver = receiver
  end
end
