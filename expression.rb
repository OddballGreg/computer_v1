class Expression
  def initialize(input)
    @expression = input.strip
  
    @sign = input.match(/^\-.*/) ? '-' : '+'

    @expression = @expression.gsub(/^[\-\+] /, '')

    @multiplier = @expression.match(/^([\d\w\+]+\.[\d\w\+]+|[\d\w\+]+) *\*/)
    @multiplier = @multiplier.nil? ? 1 : @multiplier[1].to_f
    @multiplier = 0 - @multiplier if @sign == '-'

    @variables = {}
    @expression.scan(/(\w) *\^ *(\d?)/).map{ |v| @variables[v[0]] = v[1] }

    @degree = @expression.scan(/\w *\^ *(\d?)/).map{ |v| v.first.to_i }.sum

    if @degree > 2
      puts "Polynomial Degree too high for '#{@expression}'. Cannot Resolve."
      exit
    elsif @variables.count > 1
      puts "Expression '#{@expression}' contains to many variables. Cannot Resolve."
      exit
    end
  end

  attr_accessor :expression, :sign, :multiplier, :degree, :variables

  def invert_sign!
    @sign = @sign == '+' ? '-' : '+'
    @multiplier *= -1
    return self 
  end
end