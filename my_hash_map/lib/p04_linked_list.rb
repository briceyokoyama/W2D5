class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head

  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each { |node| return node.val if node.key == key }
    nil
  end

  def include?(key)
    each { |node| return true if node.key == key }
    false
  end

  def append(key, val)
    node = Node.new(key, val)
    prev_node = last
    prev_node.next = node
    node.prev = prev_node
    node.next = @tail
    @tail.prev = node
  end

  def update(key, val)
    each do |node|
      if node.key == key
        node.val = val
        return true
      end
    end
    false
  end

  def remove(key)
    each do |node|
      if node.key == key
        node.prev.next = node.next
        node.next.prev = node.prev
        return true
      end
    end
    false
  end

  def each
    node = @head

    until node.next == @tail
      node = node.next
      yield(node)
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
