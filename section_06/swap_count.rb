#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# AtCoder Chokudai SpeedRun 001 転倒数
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

# N = 5
# a = [3, 1, 5, 4, 2]
N = 6
a = [1,2,3,4,5,6]

#N = gets.to_i
#a = gets.split(" ").map{|x| x.to_i }

b = BIT.new(N)
ans = 0
(0...a.size).each do |i|
  # 自分の位置までに入っている1の数の総和 = 自分よりも小さい数字の数 = A
  # 今まで出てきた数字の数 - A = 今までに出てきた自分よりも大きな数字の数 (転倒数)
  ans += i - b.sum(a[i])

  # 自分の場所に1を入れておきます
  b.add(a[i], 1)
end

pp ans

