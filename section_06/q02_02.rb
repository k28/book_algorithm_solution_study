#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# AtCoder Beginner Contest 077 C Sunuke Festival
# 真ん中を固定して、考えるパターン
#

def lower_bound(list, key)
  left = -1
  right = list.size

  while left + 1 < right
    mid = left + ((right - left) / 2)
    if list[mid] >= key
      right = mid
    else
      left = mid
    end
  end

  right
end

def upper_bound(list, key)
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

#N = 2
#a = [1, 5]
#b = [2, 4]
#c = [3, 6]

N = gets.to_i
a = gets.split(" ").map {|x| x.to_i}
b = gets.split(" ").map {|x| x.to_i}
c = gets.split(" ").map {|x| x.to_i}

a.sort!
b.sort!
c.sort!

total = 0

# bを固定して、考える
b.each do |i|
  # i よりも小さいaの数を求める
  a_count = lower_bound(a, i)
  
  # iより大きいcの数を求める
  c_count = N - upper_bound(c, i)

  # aとcの組み合わせがbを固定した時の組み合わせの数
  # pp "#{a_count} : #{c_count}"
  total += a_count * c_count
end

pp total

