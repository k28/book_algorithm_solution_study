#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# N個の整数のうちでk個以下の数値を選んだ時に
# 総和をWにする事ができるかO(NW)で判定するアルゴリズム
#

a = [1, 3, 5, 7, 13]
N = a.length
k = 2
W = 20

# 動的計画法, dp[i][j] jにするために選択した数値の個数(kを越えない範囲で)
dp = Array.new(N + 1) { Array.new(W + 1, 0)}

(1..N).each do |i|
  (0..W).each do |j|
    # a[i]を選ばない時
    # 何もしない(前の状態をそのまま継続)
    dp[i][j] = dp[i - 1][j]

    # a[i]を選ぶ時(実際にはi-1)
    diff = j - a[i - 1]
    if diff < 0
      # 選べない
      next
    end

    if diff == 0
      # 1つの選択でその数にできる
      dp[i][j] = 1
      next
    end

    # 選択してもその数にできない
    if dp[i - 1][diff] == 0
      next
    end

    # その数を選んだ結果、より少なくできる場合は更新する(最大はk)
    if dp[i - 1][j] != 0
      # ここまでにその数にできるパターン
      dp[i][j] = [dp[i - 1][diff] + 1, dp[i - 1][j]].min
    else
      # 初めてのパターン
      if dp[i - 1][diff] < k
        dp[i][j] = dp[i - 1][diff] + 1
      end
    end
  end
end

pp dp[N][W] != 0 ? "true" : "false"

