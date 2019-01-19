class HashSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return true if include?(num)
    resize!(2) if count == num_buckets
    self[num] << num
    self.count += 1
  end

  def remove(num)
    return true unless include?(num)
    self[num].delete(num)
    self.count -= 1
    resize!(0.5) if count <= (num_buckets * 0.25)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  attr_reader :store
  attr_writer :count

  def [](num)
    store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!(multiplier)
    elements = store.flatten
    @store = Array.new(num_buckets * multiplier) { Array.new }
    elements.each do |num|
      self[num] << num 
    end 
    store 
  end
end
