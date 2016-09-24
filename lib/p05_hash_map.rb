require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    value, increment = bucket(key).insert(key,val)
    @count += increment
    resize! if @count >= num_buckets
    value
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    value, decrement = bucket(key).remove(key)
    @count -= decrement
    value
  end

  def each(&prc)
    @store.each do |bucket|
      bucket.each do |link|
        prc.call([link.key, link.val])
      end
    end
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
    old_store = @store
    @store = Array.new(num_buckets*2) { LinkedList.new }
    @count = 0

    old_store.each do |buck|
      buck.each do |link|
        key = link.key
        value = link.val
        bucket(key).insert(key,value)
      end
    end
    nil
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
