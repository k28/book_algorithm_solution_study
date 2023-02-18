#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# BIT (Binary Indexed Tree)のサンプル実装
#

# Binary Indexed Tree
class BIT

  @bit = []
  @N = 0

  def initialize(size)
    @N = size
    @bit = Array.new(@N + 1, 0)
  end

  # 追加, a: index (1オリジン), w: 追加する値
  def add(a, w)
    x = a + 1
    while (x <= @N)
      @bit[x] += w
      x += (x & -x)
    end
  end

  # a番目までの累積和 (1オリジン)
  def sum(a)
    ret = 0
    x = a
    while (x > 0)
      ret += @bit[x]
      x -= (x & -x)
    end

    ret
  end

  def print()
    "BIT: #{@bit}"
  end

end

list = [1,3,5,7,9,13]
b = BIT.new(list.size)
(0...list.size).each do |x|
  b.add(x, list[x])
end

pp "Bit => #{b}"
pp "Sum => #{b.sum(1)}"
pp "Sum => #{b.sum(2)}"
pp "Sum => #{b.sum(list.size)}"
pp "inject:+ => #{list.inject(:+)}"

