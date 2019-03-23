class HashSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(ele)
    unless include?(ele)
      self[ele] << ele 
      @count += 1
      resize! if count == num_buckets
    end
  end

  def remove(ele)
    @count -= 1 unless self[ele].delete(ele).nil?
  end

  def include?(ele)
    self[ele].include?(ele)
  end

  private

  def [](ele)
    # optional but useful; return the bucket corresponding to `ele`
    @store[ele.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_num_buckets = num_buckets * 2
    new_arr = Array.new(new_num_buckets) { Array.new }
    @store.each do |bucket|
      bucket.each do |ele|
        new_arr[ele.hash % new_num_buckets] << ele
      end
    end
    @store = new_arr
  end
end
