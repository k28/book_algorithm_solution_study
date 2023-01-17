#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# AtCorder Typical DP Contest A (コンテスト)
#

# 問題の取り込み
W = gets.to_i
s = gets
a = s.split(" ").map{ |x| x.to_i }

# 最大の値を調べる
a_max = a.inject(:+)

# dp[i][j] i: i番目の数字を選ぶ/選ばないでjの値にできるかどうか(i=0はベース)
# その時までに、その値にできる場合はtrueを入れていく
dp = Array.new(a.length + 1) { Array.new(a_max + 1, false) }

# 初期値(何も選ばない時は0でtrue)
dp[0][0] = true

(1..a.length).each do |i|
  (0..a_max).each do |j|
    # i - 1を選ばない時
    if dp[i - 1][j] == true
      dp[i][j] = true
    end

    # i - 1を選ぶ時. 一つ前の物がtrueならtrue
    v = a[i - 1]
    if j - v >= 0
      if dp[i - 1][j - v] == true
        dp[i][j] = true
      end
    end
  end
end

# dpの最後のものでtrueの数を数えます
pp dp[a.length].count(true)

