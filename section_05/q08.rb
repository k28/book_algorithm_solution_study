#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# D - 水槽
#

N = 5
M = 3
s = [9, 1, 2, 3, 9]
# ans = 20

#N = 4
#M = 1
#s = [14, 4, 9, 7]
# ans = 8.5

#N = 8
#M = 3
#s = [11, 18, 9, 20, 4, 18, 12, 14]
# ans = 44.666667 ... 45.5になるけど良いか

# dp[i][m] iまでをm個に分けた時の平均の最大値
@dp = Array.new(N + 1) { Array.new(M + 1, 0.0) }

# sの区間[i, j)の平均値を返す. 本当は前処理で求めておくとよい
def average(s, i, j)
  return 0 if i >= j
  c = 0
  (i...j).each do |m|
    c += s[m]
  end
  return c.to_f / (j - i).to_f
end

(0..N).each do |i|
  (0...i).each do |j|
    (1..M).each do |m|
      @dp[i][m] = [@dp[i][m], @dp[j][m - 1] + average(s, j, i)].max
    end
  end
end


# pp @dp
pp @dp[N][M].to_f

