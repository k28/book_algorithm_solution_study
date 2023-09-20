#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# Educational DP Contest DP
# G - Longest Path
#
# トポロジカルソートをして解いてみるパターン
#

require 'stringio'

SEEN = Array.new()
ORDER = Array.new() # トポロジカルソート順を表す

def dfs(graph, v)
  SEEN[v] = true  # vを訪問済みにする

  # vから行ける各頂点 next_v について
  graph[v].each do |next_v|
    next if SEEN[next_v]  # 既に探索済みなら探索しない
    dfs(graph, next_v)    # 再帰的に探索
  end

  # v-outを記録する
  ORDER.push v
end

# 緩和を実施する関数

def chmax(a, b)
  if (a < b)
    return b
  end
  return a
end

# 入力
input_str = <<'EOS'
4 5
1 2
1 3
3 2
2 4
3 4
EOS

# __main__
$stdin = StringIO.new(input_str)
# $sdtin = STDIN

N, M = gets.chomp.split(' ').map(&:to_i)

# グラフの定義と読み込み(グラフはListの2次元配列)
G = Array.new(N) { Array.new() }

M.times do
  a, b = gets.chomp.split(' ').map(&:to_i)
  # 有効グラフ
  G[a - 1].push(b - 1)
end

# トポロジカルソートして、緩和の順番を求める(実際にはORDERの逆順がトポロジカルソート順)
N.times { SEEN.push(false) }  # 初期状態では全頂点が未訪問
(0...N).each do |v|
  next if SEEN[v]  # 既に訪問済みなら探索しない
  dfs(G, v)
end

# 緩和処理を行う, dpにはそこに到達するまでの最大数を入れる
dp = Array.new(N, 0)
ORDER.reverse.each do |v|
  G[v].each do |s|
    dp[s] = chmax(dp[s], dp[v] + 1)
  end
end

pp dp.max

