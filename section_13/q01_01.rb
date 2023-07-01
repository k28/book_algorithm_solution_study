#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# 無向グラフの連結成分の個数を数える
#

require 'stringio'


# グラフGに対して、頂点sを始点とした探索を行う
def search(graph, seen, s)
  n = graph.size()

  # グラフ探索のためのデータ構造
  todo = Array.new()

  # 初期条件
  seen[s] = true  # sは探索済みとする
  todo.push s     # todoはsのみを含む状態にする

  # todoが空になるまで探索を行う
  while !todo.empty? do
    v = todo.shift  # キューとして使う場合 (深さ優先探索)

    # vから辿れる頂点を全て調べる
    list = graph[v]
    list.each do |x|
      # 既に発見済みの頂点は探索しない
      next if seen[x]

      # 新たな頂点xを探索済みとしてtodoに挿入
      seen[x] = true
      todo.push x
    end
  end
end


# 入力
input_str = <<'EOS'
10 7
0 4
0 3
3 7
3 8
1 5
2 6
6 9
EOS

# __main__
$stdin = StringIO.new(input_str)
#$sdtin = STDIN

N, M = gets.chomp.split(' ').map(&:to_i)

# グラフの定義と読み込み(グラフはListの2次元配列)
G = Array.new(N) { Array.new() }
(M).times do
  a, b = gets.chomp.split(' ').map(&:to_i)
  G[a].push(b)
  G[b].push(a)
end

res = 0
seen = Array.new(N, false)  # 探索済みかどうかの判定用
N.times do |x|
  next if seen[x]   # 探索済みの頂点(既に探索済みなのでスキップ)
  res += 1
  search(G, seen, x)
end

pp res

