#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

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

def check(mid, a)
  offset = N + 1
  sum = 0
  ans = 0
  b = BIT.new(N * 2 + 10)
  b.add(sum + offset, 1)
  (0...a.size).each do |i|
    sum += a[i] <= mid ? 1 : -1
    ans += b.sum(sum + offset)
    b.add(sum + offset, 1)
  end

  return (N+1) * N / 2 / 2 < ans
end

#N = 3
#a = [10, 30, 20]

#N = 10
#a = [5,9,5,9,8,9,3,5,4,3]

N = gets.to_i
a = gets.split(" ").map{|x| x.to_i }

high = 1 << 30
low = 0
while (high - low) > 1
  mid = low + (high - low) / 2
  
  if check(mid, a)
    high = mid
  else
    low = mid
  end
end

pp high



