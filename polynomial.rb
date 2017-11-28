class Polynomial
  def initialize(equation)
    @equation = equation
    @expression = {}
    @expression[:lhs] = equation.split('=').first
    @expression[:rhs] = equation.split('=').last

    @expression[:lhs] = @expression[:lhs].scan(/(?:[\+\-] ?)*(?:\d+|\d+\.\d+) \* (?:\w *\^ *\d+)*/)
    @expression[:rhs] = @expression[:rhs].scan(/(?:[\+\-] ?)*(?:\d+|\d+\.\d+) \* (?:\w *\^ *\d+)*/)
    @expression[:lhs].each_with_index{|v, i| expression[:lhs][i] = Expression.new(v)}
    @expression[:rhs].each_with_index{|v, i| expression[:rhs][i] = Expression.new(v)}
  end

  attr_accessor :equation
  attr_accessor :expression

  def resolve
    # Make it = 0
    @expression[:rhs].each do |exp|
      @expression[:lhs] << exp.invert_sign!
    end
    @expression[:rhs] = 0

    # Remember equation degree
    equation_degree = @expression[:lhs].map{|exp| exp.degree }.max

    # Add together similar exponents (THIS CODE WILL NOT WORK WITH MULTIPLE VARIABLE EXPONENT PAIRS)
    new_expression_list = []
    (equation_degree + 1).times do |deg|
      temp_exp_set = @expression[:lhs].select{|v| v.degree == deg }
      
      value = 0
      temp_exp_set.each { |exp| value += exp.multiplier.to_f }
      
      unless temp_exp_set.empty?
        new_expression_list << Expression.new(
          {expression: "#{value.abs} * #{temp_exp_set[0].variables.first[0]}^#{temp_exp_set[0].variables.first[1]}", 
          sign: value.positive? ? '+' : '-',
          multiplier: value,
          variables: temp_exp_set[0].variables,
          degree: temp_exp_set[0].variables['X'].to_i})
      end
    end
    @expression[:lhs] = new_expression_list.reverse
    print "Reduced Form: "
    @expression[:lhs].each {|v| print "#{v.sign} #{v.expression} "}
    print "= 0\n"

    if equation_degree == 2
      a = @expression[:lhs].select{|v| v.degree == 2}[0].multiplier rescue 0
      b = @expression[:lhs].select{|v| v.degree == 1}[0].multiplier rescue 0
      c = @expression[:lhs].select{|v| v.degree == 0}[0].multiplier rescue 0
      discriminant = ((b * b) - (4.0 * a * c))

      puts "Discriminant = #{discriminant} and is strictly positive" if discriminant.positive? 
      puts "Discriminant = #{discriminant} and is strictly negative" if discriminant.negative? 
      puts "Discriminant = #{discriminant} and is null" if discriminant.zero? 

      if discriminant.negative? || a.zero?
        puts 'Unsolveable Polynomial'
      else
        r1 = ((b * -1.0) + MyMath.sqrt(discriminant)) / (2.0 * a)
        r2 = ((b * -1.0) - MyMath.sqrt(discriminant)) / (2.0 * a)
        puts "Possible Result 1: " + r1.to_s
        puts "Possible Result 2: " + r2.to_s
      end
    elsif equation_degree == 1
      a = @expression[:lhs].select{|v| v.degree == 1}[0].multiplier rescue 0
      b = @expression[:lhs].select{|v| v.degree == 0}[0].multiplier rescue 0
      if a.zero?
        puts "Unsolveable Polynomial"
      else
        r1 = -b / a
        puts "Result : " + r1.to_s
      end
    elsif equation_degree == 0
      if @expression[:lhs][0].multiplier == 0
        puts "Result: All Real Numbers"
      else
        puts "Result : Impossible"
      end
    else
      raise "Impossible Polynomial Degree"
    end
  end
end