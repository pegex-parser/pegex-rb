def XXX object
  require 'yaml'
  puts YAML.dump object
  puts 'XXX from: ' + caller.first
  exit
end

def YYY object, show_caller=true
  require 'yaml'
  puts YAML.dump object
  puts 'YYY from: ' + caller.first if show_caller
  return object
end
