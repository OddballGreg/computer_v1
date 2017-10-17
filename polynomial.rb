class Polynomial
  def initialize(equation)
    @equation = equation
    # @expression = equation.match(/(.+) (=) (.+)/).to_a[1..-1]
    @expression.split('=')
    @expression = equation.scan(/(?:[\+\-] ?)*(?:\d?|\d?\.\d?) \* (?:\w\^\d?)*/)
    puts @expression
    @expression = @expression.map{|v| v.split('-') }
    puts @expression.inspect
    expression.each_with_index{|v, i| expression[i] = Expression.new(v)}
  end

  attr_accessor :equation
  attr_accessor :expression

  def resolve
    # Make it = 0
    @expression = [Expression.new([@expression[0], expression[2].invert_sign!]), expression[1], Expression.new('0')]

  end

  def present
    puts 'Polynomial Equation = ' + @equation
    puts '---'
    @expression.each{|v| v.present(1)}
    puts '---'
  end
end