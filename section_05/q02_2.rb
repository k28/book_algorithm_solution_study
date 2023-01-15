#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require '../common/ruby/assert.rb'

#
# 部分和問題(動的計画法で解く)
#


# Wにする事ができるか解く問題
def check(n, w, a)

  # i番目の状態でjにできるかどうかの記録(i = 0 は何も選ばない状態)
  dp = Array.new(n + 1) { Array.new(w, false) }

  # 初期条件
  dp[0][0] = true
  
  (1...(n + 1)).each do |i|
    (0..w).each do |j|
      # a[(i + 1)] を選ばない時
      if dp[i - 1][j]
        dp[i][j] = true
      end

      # a[(i + 1)]を選ぶ時
      v = a[i - 1]
      if j - v >= 0
        if dp[i - 1][j - v]
          dp[i][j] = true
        end
      end
    end
  end

  # pp dp
  dp[n][w] ? "true" : "false"
end


Common::Assert.equal("true",  check(5, 10, [1, 2, 4, 5, 11]))
Common::Assert.equal("false", check(4, 10, [1, 5, 8, 11]))

