$:.unshift "#{Dir.getwd}/test/lib"

require 'testml'
require 'testml/compiler/lite'
require 'testml_bridge'

TestML.new(
  testml: 'testml/compiler-checks.tml',
  bridge: TestMLBridge,
  compiler: TestML::Compiler::Lite,
)
