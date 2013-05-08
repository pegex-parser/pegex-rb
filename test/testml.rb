require 'test/unit'
require 'testml'
require 'testml/compiler/lite'
$:.unshift "#{Dir.getwd}/test"
$:.unshift "#{Dir.getwd}/test/lib"
require 'testml_bridge'

class TestMLTestCase < Test::Unit::TestCase
  def run_testml_file(file)
    TestML.new(
      testml: file,
      bridge: TestMLBridge,
      compiler: TestML::Compiler::Lite,
    ).run(self)
  end

  (Dir.glob('test/testml/*.tml')
    .collect {|f| f.sub(/^test\//, '')}
  ).each do |file|
    method_name = 'test_' + file.gsub(/\W+/, '_').sub(/_tml$/, '')
    define_method(method_name.to_sym) do
      run_testml_file(file)
    end
  end
end