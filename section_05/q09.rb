#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# Educational DP Contest Slimes
#

INF = 1 << 60
#N = 4
#a = [10, 20, 30, 40]
N = 6
a = [7,6,8,6,1,1]

# 区間 i:jのスライムを合体させるコストの最小
@dp = Array.new(N + 1) { Array.new( N + 1, INF) }

# 累積和をとる
s = Array.new(N + 1, 0)
(0...N).each {|i| s[i + 1] = s[i] + a[i]}

# 初期条件
(0...N).each {|i| @dp[i][i + 1] = 0 }

# 更新
(2..N).each do |bet|        # 小さい区間毎に更新していく
  (0..(N-bet)).each do |i|
    # iから betまでの範囲(j)を算出する
    j = i + bet

    # i - j の範囲において、最小のコストを算出する
    # dp[i][j]を 更新する
    (i+1...j).each do |k|
      @dp[i][j] = [@dp[i][j], @dp[i][k] + @dp[k][j] + (s[j] - s[i])].min
    end
  end
end

# pp @dp
pp @dp[0][N]

