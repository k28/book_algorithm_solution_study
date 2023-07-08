#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# グラフ探索基本
#

require 'stringio'


# グラフGに対して、頂点sを始点とした探索を行う
def search(graph, s)
  n = graph.size()

  # グラフ探索のためのデータ構造
  seen = Array.new(n, false)  # 全ての頂点を未訪問にする
  todo = Array.new()

  # 初期条件
  seen[s] = true  # sは探索済みとする
  todo.push s     # todoはsのみを含む状態にする

  # todoが空になるまで探索を行う
  while !todo.empty? do
    v = todo.shift  # キューとして使う場合 (幅優先探索)
    # v = todo.pop  # スタックとして使う場合 (深さ優先探索)

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
  G[a].push(b)
end

search(G, 0)

