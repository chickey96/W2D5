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
    list = bucket(key)
    if include?(key)
      list.update(key, val)
    else
      resize!(2) if count == num_buckets
      list.append(key, val)
      self.count += 1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    self.count -= 1 if bucket(key).remove(key)
  end

  def each
    store.each do |list|
      list.each do |node|
        yield(node.key, node.val)
      end
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private
  attr_reader :store 

  def num_buckets
    @store.length
  end

  def resize!
  end

  def bucket(key)
    store[key.hash % num_buckets]
  end
end
