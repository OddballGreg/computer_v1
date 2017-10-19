class MyMath
  def self.sqrt(x)
    a = 10
    100.times do
      b = a.round(15)
      a = a - (a * a - x) / (2 * a)
      break if a.round(15) == b
    end
    a
  end

  def self.sq(a)
    a * a
  end
end