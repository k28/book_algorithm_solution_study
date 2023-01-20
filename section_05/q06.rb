#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# 個数制限付き, 部分和問題
#

a = [1, 7, 3] # 足す数
m = [2, 2, 1] # 足して良い回数
N = a.length
W = 20
INF = 1<<32

# dp[i][j] a(i)を使ってjの数を作れる時に使う回数を入れる。 初期値は大きな数.
dp = Array.new(N + 1) { Array.new(W + 1, INF) }

dp[0][0] = 0

(1..N).each do |i|
  (0...W + 1).each do |j|
    # a[i - 1]を足さないとき
    dp[i][j] = [dp[i - 1][j], 0].min if dp[i - 1][j] < INF

    # a[i - 1]を足す時
    v = a[i - 1]
    if (j >= v && dp[i][j - v] < INF && dp[i][j - v] < m[i - 1])
      dp[i][j] = [dp[i - 1][j], dp[i][j - v] + 1].min
    end
  end
end

# 値を見やすく表示するためのユーティリティメソッド
def printv(v)
    if v < INF
      print "#{'%02d'%v}  "
    else
      print "--  "
    end
end

# dpを表示するユーティリティメソッド
def printdp(dp)
  (0..W).each {|i| printv i}
  print "\n"
  (0..N).each do |i|
    (0..W).each do |j|
      printv dp[i][j]
    end
    print "\n"
  end
end

printdp dp
pp dp[N][W] < INF ? "true" : "false"


