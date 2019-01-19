class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    store[num] = true
  end

  def remove(num)
    validate!(num)
    store[num] = false
  end

  def include?(num)
    return false unless is_valid?(num)
    store[num]
  end

  private

  attr_accessor :store

  def is_valid?(num)
    (0...store.length).include?(num)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    return true if include?(num)
    store[num%store.length] << num 
  end

  def remove(num)
    store[num%store.length].delete(num)
  end

  def include?(num)
    store[num%store.length].include?(num)
  end

  private
  attr_reader :store 
  def [](num)
    # optional but useful; return the bucket corresponding to `num`
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
    return true if include?(num)
    resize!(2) if count == num_buckets
    store[num % num_buckets] << num
    self.count += 1
  end

  def remove(num)
    return true unless include?(num)
    store[num % num_buckets].delete(num)
    self.count -= 1
    resize!(0.5) if count <= (num_buckets * 0.25)
  end

  def include?(num)
    store[num % num_buckets].include?(num)
  end

  private

  attr_reader :store
  attr_writer :count

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!(multiplier)
    elements = store.flatten
    @store = Array.new(num_buckets * multiplier) { Array.new }
    elements.each do |num|
      store[num % num_buckets] << num 
    end 
    store 
  end
end
