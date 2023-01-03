#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# Frog問題 (緩和を意識)
#

INF = 1 << 60
N = 7
h = [2, 9, 4, 5, 1, 6, 10]
list = Array.new(N, INF)

# listのi番目の物と b を比べてbの方が小さければ更新する
def chmin(list, i, b)
  list[i] = b if list[i] > b
end

# 初期状態
list[0] = 0

(1...N).each do |i|
  # 隣からの移動
  chmin(list, i, (h[i - 1] - h[i]).abs + list[i - 1])

  # 1つ前からの移動
  if i - 2 >= 0
    chmin(list, i, (h[i - 2] - h[i]).abs + list[i - 2])
  end
end

# pp list
pp list[N-1]

