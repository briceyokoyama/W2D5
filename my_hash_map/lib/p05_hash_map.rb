require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    bucket = bucket(key)
    unless bucket.update(key, val)
      bucket.append(key, val) 
      @count += 1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    if bucket(key).remove(key)
      @count -= 1
    end
  end

  def each
    @store.each { |bucket| bucket.each {|node| yield(node.key, node.val)} } if block_given?
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    # Go Fish
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end

# def resize!
#     new_num_buckets = num_buckets * 2
#     new_arr = Array.new(new_num_buckets) { Array.new }
#     @store.each do |bucket|
#       bucket.each do |ele|
#         new_arr[ele.hash % new_num_buckets] << ele
#       end
#     end
#     @store = new_arr
#   end
