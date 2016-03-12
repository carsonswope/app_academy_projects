class Array
  def my_uniq
    self.uniq
  end

  def two_sum
    res = []
    (self.length - 1).times do |start_index|
      ((start_index + 1)...self.length).each do |end_index|
        res << [start_index, end_index] if self[start_index] + self[end_index] == 0
      end
    end
    res
  end

  def my_transpose
    if empty?
      []
    else
      new_ary = Array.new(self[0].length) { Array.new(length) }
      each_with_index do |el, i|
        el.each_with_index do |el2, j|
          new_ary[j][i] = self[i][j]
        end
      end
      new_ary
    end
  end

  def stock_picker
    res = []
    (self.length - 1).times do |start_index|
      ((start_index + 1)...self.length).each do |end_index|
        profit = self[end_index] - self[start_index]
        if res.empty? && profit > 0
          res = [start_index, end_index, profit]
        elsif !res.empty? && profit > res[2]
          res = [start_index, end_index, profit]
        end
      end
    end
    res.take(2)
  end
end
