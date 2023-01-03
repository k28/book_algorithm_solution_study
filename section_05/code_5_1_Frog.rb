#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# Frog問題
#

INF = 1 << 60
N = 7
h = [2, 9, 4, 5, 1, 6, 10]
list = Array.new(N, INF)

# 初期状態
list[0] = 0

(1...N).each do |i|
  # 隣からの移動
  c1 = (h[i - 1] - h[i]).abs + list[i - 1]

  # 1つ前からの移動
  c2 = INF
  if i - 2 >= 0
    c2 = (h[i - 2] - h[i]).abs + list[i - 2]
  end

  list[i] = [c1, c2].min
end

# pp list
pp list[N-1]

