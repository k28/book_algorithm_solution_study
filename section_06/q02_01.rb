#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# AtCoder Beginner Contest 077 C Sunuke Festival
#

# keyと同じ場合は小さいとみなしたlower_bound
def lower_bound(list, key)
  left = -1
  right = list.size

  while left + 1 < right
    mid = left + ((right - left) / 2)
    if list[mid] > key
      right = mid
    else
      left = mid
    end
  end

  right
end

#N = 3
#a = [1, 5]
#b = [2, 4]
#c = [3, 6]

N = gets.to_i
a = gets.split(" ").map {|x| x.to_i}
b = gets.split(" ").map {|x| x.to_i}
c = gets.split(" ").map {|x| x.to_i}

b.sort!
c.sort!

cache = Hash.new([])

total = 0
# aを固定して, 選択可能なbの最小値を調べる
a.each do |i|
  bl = lower_bound(b, i)
  if bl >= b.size
    next
  end

  if cache.include?(bl)
    total += cache[bl]
    next
  end
  
  # b のbl以降でcから選択可能なものを調べる
  btotal = 0
  (bl...b.size).each do |bp|
    cl = lower_bound(c, b[bp])
    if cl >= c.size
      next
    end

    cache[bl] = (c.size - cl)
    btotal += (c.size - cl)
  end
  cache[bl] = btotal
  total += btotal
end

pp total

