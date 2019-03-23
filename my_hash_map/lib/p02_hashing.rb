class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    self.inject("apple") do |acc, ele|
      acc.hash ^ ele.hash
    end.hash

  end
end

class String
  def hash
    str = self+"apple"
    
    str.split("").inject do |acc, char|
      acc.ord.hash + char.ord
    end.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    inject(0) do |acc, (k, v)|
      acc ^ k.hash + v.hash * 2
    end.hash
  end
end
