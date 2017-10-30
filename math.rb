class MyMath
  PRECISION = 15

  def self.sqrt(x)
    a = 10
    100.times do
      b = a.round(PRECISION)
      a = a - (a * a - x) / (2 * a)
      break if a.round(PRECISION) == b
    end
    a
  end

  def self.sq(a)
    a * a
  end
end