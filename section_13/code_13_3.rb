#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# 幅優先探索で最短距離を求める
#
require 'stringio'

# 入力: グラフGと、探索の視点s
# 出力: sから各頂点への最短路長を表す配列
def bfs(graph, s)
  n = graph.size()        # 頂点の数
  dist = Array.new(n, -1) # 前頂点を「未訪問(-1)」に初期化, 頂点からの距離を格納する.
  que = Array.new()

  # 初期条件(頂点0を初期頂点とする)
  dist[0] = 0
  que.push 0

  # bfs開始 (キューが空になるまで探索を行う)
  while !que.empty? do
    v = que.shift

    # vから辿れる頂点を全て調べる
    graph[v].each do |x|
      next if dist[x] != -1
      # 新たな頂点xについて、距離情報を更新してキューに入れる
      # (vの位置から1移動した事になるので、+1する)
      dist[x] = dist[v] + 1
      que.push x
    end
  end

  return dist
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
# 無向グラフとして読み込みます
G = Array.new(N) { Array.new() }
(M - 1).times do
  a, b = gets.chomp.split(' ').map(&:to_i)
  G[a].push(b)
  G[b].push(a)
end

# 頂点0を始点としたBFS
dist = bfs(G, 0)

# 結果を出力
(0...N).each do |v|
  pp "#{v} : #{dist[v]}"
end


