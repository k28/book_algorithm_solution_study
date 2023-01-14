#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# 区分分割 (サンプルの問題がないので、テストが書けない。 動作未検証)
#

def chmin(a, b)
  return [a, b].min
end

INF = 2 ^ 60
N = 10
K = 4
c = Array.new(N + 1) { Array.new(N+1, 1) }

# TODO cに値を代入する

# dpテーブル定義
dp = Array.new(N + 1, INF)

# dp 初期条件
dp[0] = 0

# dp ループ

(0..N).each do |i|
  (0...i).each do |j|
    dp[i] = chmin(dp[i], dp[j] + c[j][i])
  end
end

pp dp[N]

