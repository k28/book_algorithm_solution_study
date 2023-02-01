#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# 2分探索法を用いて、「ペア和を最適化する問題」に対する全探索解法を高速化する
#

INF = 1 << 32

def lower_bound(l, r, list, key)
  left = l
  right = r

  while right - left > 1
    mid = left + (right - left) / 2
    if mid >= key
      right = mid
    else
      left = mid
    end
  end

  right
end

a = [1,  3, 5, 14, 7, 2,  15, 22, 8, 10]
b = [33, 2, 1, 5,  6, 23, 17,  9, 11, 7]
K = 26 
N = a.size
min_value = INF

# bをソート
b.sort!

# aを固定して解く
a.each do |i|
  # bの中で、K - a[i]以上の範囲で最小値を示すindex
  bi = lower_bound(0, N - 1, b, K - i)

  pp "#{i} : #{b[bi]} , #{K - i}"
  # min_valueと比較する
  if i + b[bi] < min_value
    min_value = i + b[bi]
  end
end

pp min_value

