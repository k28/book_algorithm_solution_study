#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# グラフ上の2頂点 s -> t の経路があるか調べる
# 深さ優先探索を用いて実装
#

require 'stringio'

# 深さ優先探索
SEEN = Array.new()
def dfs(graph, v)
  SEEN[v] = true  # vを訪問済みにする

  # vから行ける頂点next_vについて
  (graph[v]).each do |next_v|
    next if SEEN[next_v]
    dfs(graph, next_v)
  end
end

# 幅優先探索
def dfs_bfs(graph, s)
  n = graph.size()

  # グラフ探索のためのデータ構造
  todo = Array.new()

  # 初期条件
  SEEN[s] = true # sを探索済みにする
  todo.push s    # todoはsのみを含む状態にする

  # todoが空になるまで探索を行う
  while !todo.empty? do
    v = todo.pop

    # vから辿れる頂点を全て調べる
    list = graph[v]
    list.each do |x|
      # 既に発見済みの頂点は探索しない
      next if SEEN[x]

      # 新たな頂点を探索済みとして、todoに挿入
      SEEN[x] = true
      todo.push x
    end
  end
end

# 入力
input_str = <<'EOS'
8 13 4 5
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

N, M, s, t = gets.chomp.split(' ').map(&:to_i)

# グラフの定義と読み込み(グラフはListの2次元配列)
G = Array.new(N) { Array.new() }
(M - 1).times do
  a, b = gets.chomp.split(' ').map(&:to_i)
  G[a].push(b)
end

# 頂点sをスタートとした検索
N.times { SEEN.push(false) }  # 初期状態では全頂点が未訪問
dfs_bfs(G, s)

# tに辿り着けるかどうか
pp SEEN[t] ? "yes" : "no"

