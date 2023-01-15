#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# Vacation (動的計画法)
#

# 入力を取り込む
@N = gets.to_i # 休みの日数
@A = []        # 海で泳ぐ
@B = []        # 山で虫取り
@C = []        # 家で宿題

@N.times do
  s = gets
  lines = s.split(" ").map{ |x| x.to_i }
  @A.push lines[0]
  @B.push lines[1]
  @C.push lines[2]
end

def chmax(a, b)
  return [a, b].max
end

# dp[i][j] jは0:a, 1:b, 2:cをそれぞれ前回選んだ場合の最大値. i番目
dp = Array.new(@N + 1) { Array.new(3, 0) }

(0..@N).each do |i|
  (0...3).each do |j|
    if i == 0
      # 初めは何も選んでいない場合
      next
    end

    # a を選ぶ場合 : 前回のb, c の最大値にaの値を足した物が最大
    dp[i][0] = chmax(dp[i - 1][1] + @A[i - 1], dp[i - 1][2] + @A[i - 1])

    # b を選ぶ場合
    dp[i][1] = chmax(dp[i - 1][0] + @B[i - 1], dp[i - 1][2] + @B[i - 1])

    # cを選ぶ場合
    dp[i][2] = chmax(dp[i - 1][0] + @C[i - 1], dp[i - 1][1] + @C[i - 1])
  end
end

# それぞれの最大の物が考えられる最大値
pp [dp[@N][0], dp[@N][1], dp[@N][2]].max

