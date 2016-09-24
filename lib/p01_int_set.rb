class MaxIntSet

  def initialize(max)
    @max = max
    @store = Array.new(max + 1, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
    nil
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private
  attr_reader :store, :max

  def is_valid?(num)
    num <= @max && num > 0
  end

  def validate!(num)
    raise ArgumentError.new("Out of bounds") unless is_valid?(num)
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
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
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
    return if include?(num)
    @count += 1
    resize! if @count >= num_buckets
    self[num] << num
    nil
  end

  def remove(num)
    return unless include?(num)
    @count -= 1
    self[num].delete(num)
    nil
  end

  def include?(num)
    self[num].include?(num)
  end

  def inspect
    "<ResizingIntSet: count: #{@count}, buckets: #{num_buckets}\nmembers: #{@store}>"
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets*2) { Array.new }
    @count = 1

    old_store.flatten(1).each do |el|
      insert(el)
    end
    nil
  end
end
