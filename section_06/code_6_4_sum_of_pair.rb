#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# 2分探索法を用いて、「ペア和を最適化する問題」に対する全探索解法を高速化する
#

INF = 1 << 32

def lower_bound(list, key)
  left = -1
  right = list.size

  while left + 1 < right
    mid = left + (right - left) / 2
    if list[mid] >= key
      right = mid
    else
      left = mid
    end
  end

  right
end

#a = [1,  3, 5, 14, 7, 2,  15, 22, 8, 10]
#b = [33, 2, 1, 5,  6, 23, 17,  9, 11, 7]

a = [1, 3, 6, 9]
b = [2, 3, 4, 5, 9]
K = 16
N = a.size
min_value = INF

# bをソート
b.sort!

# aを固定して解く
a.each do |i|
  # bの中で、K - a[i]以上の範囲で最小値を示すindex
  bi = lower_bound(b, K - i)

  next if bi >= b.size

  # min_valueと比較する
  if i + b[bi] < min_value
    pp "# #{i}, #{b[bi]}"
    min_value = i + b[bi]
  end
end

pp min_value

