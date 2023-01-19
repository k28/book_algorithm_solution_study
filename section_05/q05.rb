#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# 個数制限なし, 部分和問題
#

a = [2, 8, 13]
N = a.length
W = 21
dp = Array.new(N + 1) { Array.new(W + 1, false) }

dp[0][0] = true

(1..N).each do |i|
  (0...W + 1).each do |j|
    # a[i - 1]を足さないとき
    dp[i][j] = dp[i - 1][j]

    # a[i - 1]を足す時
    v = a[i - 1]
    if j - v < 0
      next
    end
    # j を vで割った余りの値がtrueならその数値を作る事ができる
    rest = j % v
    if (dp[i - 1][rest])
      dp[i][j] = true
    end
    # >> これは、dp[i][j - v] がtrueならtrueを入れる事と実質一緒
    # 回答例の場合は、上記の方法でアルゴリズムを組み立てていた
  end
end

pp dp[N][W]

