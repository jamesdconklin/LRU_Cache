FIXNUM_MAX = (2**(0.size * 8 -2) -1)

class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash(alpha = 4348676780902427857, beta = 23)
    current_hash = alpha

    each_with_index do |el, idx|
      num = FIXNUM_MAX - beta*((idx + 1) * el.hash)**2
      num = num % FIXNUM_MAX
      current_hash = current_hash ^ num.hash
    end

    current_hash
    # inject(alpha) { |accum, el| accum ^ el.hash}
  end
end

class String
  def hash
    each_char.map(&:ord).hash(3458764513822084649, 431)
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    to_a.sort.hash(1725073571093108792, 113)
  end
end
