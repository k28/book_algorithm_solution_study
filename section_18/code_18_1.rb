#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# 重みつき最大安定集合問題を 木上の動的計画法で解く
#

# 動的計画法
# v : 注目する頂点
# p : 親の頂点
def dfs(v, p = -1)
  # 最初に各子頂点を探索しておく
  G[v].each do |ch|
    next if ch == p
    dfs(ch, v)
  end

  # 帰りがけに動的計画法
  DP1[v] = 0
  DP2[v] = W[v] 

  G[v].each do |ch|
    next if ch == p
    DP1[v] += [DP1[ch], DP2[ch]].max
    DP2[v] += DP1[ch]
  end
end

# グラフの入力
# N: 頂点数, M: 辺数

# 入力
input_str = <<'EOS'
13
7
3
5
4
2
13
9
8
5
10
1
13
8
0 1
0 2
0 3
1 4
1 5
2 6
3 7
3 8
5 9
5 10
6 11
6 12
EOS


# __main__
$stdin = StringIO.new(input_str)
#$sdtin = STDIN

#頂点数
N = gets.chomp.to_i
# 重みとグラフの入力受取
W = Array.new(N, 0)
(N).times do |i|
  W[i] = gets.chomp.to_i
end

G = Array.new(N) { Array.new() }
(N - 1).times do |i|
  a, b = gets.chomp.split(' ').map(&:to_i)
  G[a].push b
  G[b].push a
end

# 探索, 仮に頂点0を根とする
root = 0
# 木上の動的計画法テーブル
# 頂点vを根とする部分木内で安定集合の重みの最大値
DP1 = Array.new(N, 0)
DP2 = Array.new(N, 0)
dfs(root)

# 結果を出力(dp1, dp2のrootの最大のもの)
pp [DP1[root], DP2[root]].max


