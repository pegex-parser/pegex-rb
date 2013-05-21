require 'pegex'
require 'pegex/tree'

$grammar = <<'...';
expr: add_sub
add_sub: mul_div+ % /~([<PLUS><DASH>])~/
mul_div: exp+ % /~([<STAR><SLASH>])~/
exp: token+ % /~<CARET>~/
token: /~<LPAREN>~/ expr /~<RPAREN>~/ | number
number: /~(<DASH>?<DIGIT>+)~/
...

class Calculator < Pegex::Tree
  def got_number(num)
    num.to_i
  end

  def got_add_sub(list)
    list.flatten!
    while list.size > 1 do
      (a, op, b) = list.slice!(0, 3)
      list.unshift (op == '+') ? (a + b) : (a - b)
    end
    list.first
  end

  def got_mul_div(list)
    list.flatten!
    while list.size > 1 do
      (a, op, b) = list.slice!(0, 3)
      list.unshift (op == '*') ? (a * b) : (a / b)
    end
    list
  end

  def got_exp(list)
    list.flatten!
    while list.size > 1 do
      (a, b) = list.slice!(-2, 2)
      list.push a ** b
    end
    list
  end
end

def calc(expr)
  calculator = pegex($grammar, receiver=Calculator)
  begin
    result = calculator.parse(expr)
    puts "#{expr} = #{result}"
  rescue
    puts $!
  end
end

loop do
  STDOUT.write "\nEnter an equation: "
  input = STDIN.readline.chomp
  break if input.empty?
  calc input
end

# calc '2'
# calc '2 * 4'
# calc '2 * 4 + 6'
# calc '2 + 4 * 6 + 1'
# calc '2 + (4 + 6) * 8'
# calc '(((2 + (((4 + (6))) * (8)))))'
# calc '2 ^ 3 ^ 2'
# calc '2 ^ (3 ^ 2)'
# calc '2 * 2^3^2'
# calc '(2^5)^2'
# calc '2^5^2'
# calc '0*1/(2+3)-4^5'
# calc '2/3+1'
