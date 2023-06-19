#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# 二部グラフ判定
#

require 'stringio'

# -1: 未探索, 1: 黒, 0: 白
COLOR = Array.new()

# 再帰的に二部グラフか判定を行う
def dfs(graph, v, cur = 0)
  COLOR[v] = cur
  graph[v].each do |next_v|
    # 隣頂点が既に色確定していた場合
    if COLOR[next_v] != -1
      # 同じ色が隣接した場合は二部グラフでない
      return false if COLOR[next_v] == cur
      # 色が確定した場合には探索しない
      next
    end

    # 隣接頂点の色を変えて、再起的に探索
    # falseが帰ったらfalseを返す
    return false if !dfs(graph, next_v, 1 - cur)
  end

  true
end


# 入力
input_str = <<'EOS'
8 13
4 1
4 2
4 6
1 3
1 6
2 5
2 7
6 7
3 0
3 7
7 0
0 5
EOS

# __main__
$stdin = StringIO.new(input_str)
#$sdtin = STDIN

N, M = gets.chomp.split(' ').map(&:to_i)

# グラフの定義と読み込み(グラフはListの2次元配列)
G = Array.new(N) { Array.new() }
(M - 1).times do
  a, b = gets.chomp.split(' ').map(&:to_i)
  # 無向グラフとして読み込み
  G[a].push(b)
  G[b].push(a)
end

# 探索
N.times { COLOR.push -1 } # 初期状態では全頂点が未訪問
is_bipartite = true
(0...N).each do |v|
  next if COLOR[v] != -1
  is_bipartite = false if !dfs(G, v)
end

pp is_bipartite ? "yes" : "no"

