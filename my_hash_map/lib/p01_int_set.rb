class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max + 1, false)
  end

  def insert(num)
    raise 'Out of bounds' unless is_valid?(num)

    @store[num] = true
    true
  end

  def remove(num)
    raise 'Out of bounds' unless is_valid?(num)

    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  attr_accessor :max, :store

  def is_valid?(num)
    num.between?(0, max)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless include?(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].any? { |n| num == n }
  end

  def change_store()
    self.store = []
  end

  private
  attr_accessor :store

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet

  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless include?(num)
      self[num] << num 
      @count += 1
      resize! if count == num_buckets
    end
  end

  def remove(num)
    @count -= 1 unless self[num].delete(num).nil?
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_num_buckets = num_buckets * 2
    new_arr = Array.new(new_num_buckets) { Array.new }
    @store.each do |bucket|
      bucket.each do |num|
        new_arr[num % new_num_buckets] << num
      end
    end
    @store = new_arr
  end
end
