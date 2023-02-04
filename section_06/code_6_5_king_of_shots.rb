#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# AtCoder Beginner Contest 023 D 射撃王
#
# 入力
# 4
# 5 6
# 12 4
# 14 7
# 21 2
#
# 出力
# 23
#

# 大きな値を1つ決める
INF = 1 << 60

# 入力
N = gets.chomp().to_i
h = Array.new(N)
s = Array.new(N)
(0...N).each do |i|
  l = gets.chomp().split(' ')
  h[i] = l[0].to_i
  s[i] = l[1].to_i
end

# 風船を割るまでの時間制限
t = Array.new(N, 0)
# ペナルティをmidに設定しながら探索する
left = 0
right = INF
while (right - left) > 1
  mid = left + ((right - left) / 2)

  # 時間(mid)以内に風船を全て割れるか調べる
  ok = true
  (0...N).each do |i|
    if h[i] > mid 
      ok = false
      break
    else
      # 残り時間を計算しておく
      t[i] = (mid - h[i]) / s[i]
    end
  end
  
  if ok
    # 残り時間をソート
    t.sort!
    # pp "#{mid} #{t}"
    (0...N).each do |i|
      if t[i] < i
        # 時間切れになった
        ok = false
        break
      end
    end
  end

  if ok
    right = mid
  else
    left = mid
  end
end

pp right

