#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# 編集距離を求める
# dp[i-j]はsとtそれぞれの文字の位置の時の編集距離を保持する
#

INF = 1 << 29

s = "algorithm"
t = "logistic"

@dp = Hash.new {INF}  # 初期値をINFで初期化

def make_key(i, j)
  return "#{i}-#{j}"
end

def chmin(i, j, v)
  ij = @dp[make_key(i, j)]
  if v < ij
    @dp[make_key(i,j)] = v
  end
end

# 初期条件
@dp[make_key(0, 0)] = 0

(0...s.length + 1).each do |i|
  (0...t.length + 1).each do |j|
    # 変更操作
    if i > 0 && j > 0
      if s[i - 1] == t[j - 1]
        chmin(i, j, @dp[make_key(i - 1, j - 1)])
      else
        chmin(i, j, @dp[make_key(i - 1, j - 1)] + 1)
      end
    end

    # 削除操作
    if i > 0
      chmin(i, j, @dp[make_key(i - 1, j)] + 1)
    end
    
    # 挿入操作(tの文字列削除と同等の処理)
    if j > 0
      chmin(i, j, @dp[make_key(i, j - 1)] + 1)
    end
  end
end

# 結果を出力(最後の配列に結果が格納されている)
pp @dp[make_key(s.length, t.length)]

