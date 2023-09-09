#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# フロイド・ワーシャル法
#

# 無限大を表す値 (ここでは十分大きな値を用いることにする)
INF = 2**60

# __main__

# 入力
input_str = <<'EOS'
6 9 0
0 1 3
0 2 5
1 2 4
1 3 12
2 3 9
2 4 4
3 5 2
4 3 7
4 5 8
EOS

# __main__
$stdin = StringIO.new(input_str)
#$sdtin = STDIN

# 頂点数, 辺数, 始点 (始点は今回は使用しない)
N, M, s = gets.chomp.split(' ').map(&:to_i)

# dp配列 (INFで初期化) . dp[i][j] => i -> jへの最短経路
dp = Array.new(N) { Array.new(N, INF) }

# dp初期条件
M.times do 
  a, b, w = gets.chomp.split(' ').map(&:to_i)
  dp[a][b] = w
end

# dp遷移
N.times do |k|
  N.times do |i|
    N.times do |j|
      dp[i][j] = [dp[i][j], dp[i][k] + dp[k][j]].min
    end
  end
end

# 結果出力
# もし dp[v][v] < 0 なら負閉路が存在する
exist_neagtive_cycle = false
N.times do |v|
  exist_neagtive_cycle = true if dp[v][v] < 0
end

if exist_neagtive_cycle
  pp "NEGATIVE CYCLE"
else
  N.times do |i|
    N.times do |j|
      pp "-----" if j
      if dp[i][j] < INF/2
        pp "#{i} => #{j} #{dp[i][j]}"
      else
        pp "#{i} => #{j} INF"
      end
    end
  end
end


