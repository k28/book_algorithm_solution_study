#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# Frog問題 (配る遷移形式で解く)
#

INF = 1 << 60
N = 7
h = [2, 9, 4, 5, 1, 6, 10]
list = Array.new(N, INF)

# listのi番目の物と b を比べてbの方が小さければ更新する
def choose_minimum(list, i, b)
  list[i] = b if list[i] > b
end

# 初期状態
list[0] = 0

(0...N).each do |i|
  if i + 1 < N
    p = i + 1
    choose_minimum(list, p, list[i] + (h[i] - h[p]).abs)
  end

   if i + 2 < N
    p = i + 2
    choose_minimum(list, p, list[i] + (h[i] - h[p]).abs)
   end
end

# pp list
pp list[N-1]


