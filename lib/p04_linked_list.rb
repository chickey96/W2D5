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
  attr_reader :head, :tail

  def initialize
    @head = Node.new
    @tail = Node.new
    head.next = tail
    tail.prev = head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    head.next
  end

  def last
    tail.prev
  end

  def empty?
    head.next == tail
  end

  def get(key)
    each { |node| return node.val if node.key == key }
  end

  def include?(key)
    check_nodes(head, key)
  end

  def append(key, val)
    return true if include?(key)
    node = Node.new(key, val)
    tail.prev.next = node
    node.prev = tail.prev
    tail.prev = node
    node.next = tail
  end

  def update(key, val)
    each do |node|
      if node.key == key
        node.val = val
        break
      end
    end
  end

  def remove(key)
    each do |node|
      if node.key == key 
        node.next.prev = node.prev 
        node.prev.next = node.next 
        return true
      end
    end
    false
  end

  def each(node = head.next, &prc)
    return if node == tail
    prc ||= Proc.new { |i| i }
    prc.call(node)
    each(node.next, &prc)
  end

  private

  def check_nodes(node, key)
    return true if node.key == key
    return false if node.next == tail 
    check_nodes(node.next, key)
  end
 
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
