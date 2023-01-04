#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# Frog問題. 再帰を使って全探索
#

INF = 1 << 60

# 足場0からiまでの最小コスト
def walk(list, i)
  # ベースケース (足場のコストは0)
  return 0 if i == 0

  # 1つ前から来た場合のコスト
  v = walk(list, i - 1) + (list[i] - list[i - 1]).abs

  # 2つ前から来た場合のコスト
  v2  = INF
  if i > 1
    v2 = walk(list, i - 2) + (list[i] - list[i - 2]).abs
  end

  # 小さい方が足場0からの最小コスト
  return [v, v2].min
end

h = [2, 9, 4, 5, 1, 6, 10]
pp walk(h, h.size - 1)  # 8
