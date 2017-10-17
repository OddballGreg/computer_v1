class Expression
  def initialize(input)
    if input.class == Array
      @expression = input
    elsif input.class == String
      @expression = input.strip
      return if @expression == '='
    
      @sign = input.match(/$\-.*/) ? '-' : '+'

      if @expression.match /[\w\d]+ [\+\-] [\w\d]+/
        @expression = @expression.match(/([\w\d\ \^\*\\]+) ([\+\-] ?.+)/)
        @expression = @expression.to_a[1..-1].map{ |v| Expression.new(v) }
      end
      
      if @expression.class == String
        @degree = @expression.scan(/\w\^(\d)/).map{ |v| v.first.to_i }.sum
      end

      if !@degree.nil? && @degree > 2
        puts "Polynomial Degree too high for '#{@expression}'. Cannot Resolve."
        exit
      end
    else
      raise 'Unexpected Input Type For Expression Construction'
    end
  end

  attr_accessor :expression
  attr_accessor :degree
  attr_accessor :sign

  def present(indent)
    if @expression.class == String
      print "  " * indent
      print @expression + "\n"
    else
      puts "  " * indent + 'expression = ['
      @expression.each{|v| v.class == String ? v : v.present(indent + 1)}
      puts "  " * indent + '] /expression'
    end
  end

  def add_expression(new_expression)
    if @expression.class == String
      @expression = [@expression, new_expression]
    else
      @expression << new_expression
    end
  end

  def invert_sign!
    if @sign == '-'
      @sign = '+'
      if @expression.class == String
        @expression = @expression.tr('-', '+')
      else
        @expression.each{ |v| v.invert_sign! }
      end
    else
      @sign = '-'
      if @expression.class == String
        @expression = @expression.tr('+', '-')
      else
        @expression.each{ |v| v.invert_sign! }
      end
    end
  end

end