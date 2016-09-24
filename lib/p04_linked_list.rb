class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def remove
    @prev.next = @next
    @next.prev = @prev
    @val
  end

  def insert_after(node)
    @prev = node
    @next = node.next
    node.next.prev = self
    node.next = self
    @val
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  attr_reader :sentinel_head, :sentinel_tail
  include Enumerable
  def initialize
    @sentinel_head = Link.new()
    @sentinel_tail = Link.new()
    @sentinel_head.next = @sentinel_tail
    @sentinel_tail.prev = @sentinel_head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    empty? ? @sentinel_head : @sentinel_head.next
  end

  def last
    @sentinel_tail.prev
  end

  def empty?
    @sentinel_head.next == @sentinel_tail
  end

  def get(key)
    value = nil
    each do |node|
      if node.key == key
        value = node.val
        break
      end
    end
    value
  end

  def include?(key)
    find(key) ? true : false
  end

  def find(key)
    found = nil

    each do |node|
      if node.key == key
        found = node
        break
      end
    end

    found
  end

  def insert(key, val)
    found = find(key)

    if found
      found.val = val
      return [val,0]
    end

    node = Link.new(key,val)
    node.insert_after(last)

    [val,1]
  end

  def <<(kv)
    key, value = kv
    insert(key, value)
  end

  def remove(key)

    found = find(key)
    if found
      found.remove
      return [found.val, 1]
    end

    [nil, 0]
  end

  def each(&prc)
    walker = @sentinel_head.next
    until walker == @sentinel_tail
      prc.call(walker)
      walker = walker.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
   def to_s
     inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
