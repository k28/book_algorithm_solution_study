#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# 編集距離を求める LCS (Longest Common Subsequence)
# dp[i-j]はsとtそれぞれの文字の位置の時の編集距離を保持する
# AtCoderに提出すると時間がかかりすぎる... 最後の文字の組み立てがNGだね
#

INF = 1 << 29

#s = "abracadabra"
#t = "avadakedavra"

s = gets.chomp
t = gets.chomp

#pp "s: #{s}"
#pp "t: #{t}"

@dp = Array.new(s.length + 1) { Array.new(t.length + 1, 0) }
@v = ""

def chmin(a, b)
  if a > b
    b
  else
    a
  end
end

def chmax(a, b)
  if a > b
    a
  else
    b
  end
end

# 初期条件
@dp[0][0] = 0

(0...s.length + 1).each do |i|
  (0...t.length + 1).each do |j|
    # 変更操作
    if i > 0 && j > 0
      if s[i - 1] == t[j - 1]
        @dp[i][j] = chmax(@dp[i][j], @dp[i-1][j-1] + 1)
      else
        @dp[i][j] = chmax(@dp[i][j], @dp[i-1][j-1])
      end
    end

    # Sに1文字追加
    if i > 0
      @dp[i][j] = chmax(@dp[i][j], @dp[i-1][j])
    end
    
    # Tに1文字追加
    if j > 0
      @dp[i][j] = chmax(@dp[i][j], @dp[i][j-1])
    end
  end
end

# 最短ルートで文字列を見つける
# dpの後ろから、dp[0][0]に向かって、数が少なくなる角(最短距離)を進む
i = s.length
j = t.length
c = @dp[i][j]
ans = ""
while true do
  # 終了条件
  if @dp[i][j] == 0
    break
  end
  # 右上に向かって進めるか
  if @dp[i-1][j-1] < c && @dp[i-1][j] < c && @dp[i][j-1] < c
    ans = s[i-1] + ans
    c = @dp[i-1][j-1]
    i -= 1
    j -= 1
    next
  end

  # 数値の切れ目(コーナー)を探します

  # 左上に向かって進む
  if @dp[i-1][j-1] == c && @dp[i-1][j] == c && @dp[i][j-1] == c
    i -= 1
    j -= 1
    next
  end

  # 上に進めるか
  if @dp[i-1][j-1] < c && @dp[i][j-1] < c && @dp[i-1][j] == c
    i -= 1
    next
  end

  # 左に進めるか
  if @dp[i-1][j-1] < c && @dp[i-1][j] < c && @dp[i][j-1] == c
    j -= 1
    next
  end

  i -= 1
  j -= 1
end

# 結果を出力(最後の配列に結果が格納されている)
#pp @dp
#pp @dp[s.length][t.length]
#pp c
print ans

