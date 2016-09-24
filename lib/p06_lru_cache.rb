require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    fetch = @map[key]
    if fetch.nil?
      val = @prc.call(key)
      node = Link.new(key,val)
      until count < @max
        eject!
      end
      @map[key] = node
      update_link!(node)
      return val
    else
      fetch.remove
      update_link!(fetch)
      return fetch.val
    end

  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    link.insert_after(@store.sentinel_head)
  end

  def eject!
    ejectee = @store.last
    raise "Can't remove sentinel" if ejectee == @store.sentinel_head
    ejectee.remove
    @map.delete(ejectee.key)
  end
end
