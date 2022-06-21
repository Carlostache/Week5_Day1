require "byebug"

class MaxIntSet

  def initialize(max)
    @set = Array.new(max, false)
  end

  def insert(num)
    if num > @set.length || num < 0
      raise "Out of bounds"
    else
      @set[num] = true
    end
  end

  def remove(num)
    @set[num] = false
  end

  def include?(num)
    return true if @set[num] == true

    false
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num] << num
  end

  def remove(num)
    @store[num].delete(num)
  end

  def include?(num)
    return true if @store[num].include?(num)

    false  
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
    if self.include?(num) == false
      self[num] << num
      @count += 1
    end
  end

  def remove(num)
    if self.include?(num) == true
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    return true if @store[num].include?(num)

    false
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    if @count > num_buckets
      old_nums = @store.flatten
      @store = Array.new(num_buckets*2) {Array.new}
      old_nums.each { |num| @store.insert(num) }
    end
  end
end
