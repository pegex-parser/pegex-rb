require 'test/unit'
$:.unshift "#{Dir.getwd}/lib"
require 'testml'
require 'testml/compiler/lite'
$:.unshift "#{Dir.getwd}/test"
$:.unshift "#{Dir.getwd}/test/lib"
require 'testml_bridge'

class TestMLTestCase < Test::Unit::TestCase
  def test_compiler_equivalence_tml
    TestML.new(
      testml: 'testml/compiler-equivalence.tml',
      bridge: TestMLBridge,
      compiler: TestML::Compiler::Lite,
    ).run(self)
  end
end
