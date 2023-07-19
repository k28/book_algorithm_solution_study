#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# トポロジカルソートを幅優先探索で実装てみる
#
# 出次数 deg[v] 頂点vを始点とする辺の個数
# シンク 出次数が0であるような頂点
#
# 戦略
# シンクを並べていけば、トポロジカルソートになる
#

require 'stringio'

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

# 出次数
deg = Array.new(N, 0)

# グラフの定義と読み込み(グラフはListの2次元配列)
G = Array.new(N) { Array.new() }
(M - 1).times do
  a, b = gets.chomp.split(' ').map(&:to_i)
  G[b].push(a) # 逆向きに辺を張ることで、頂点に向かっている物を調べられるようにします
  deg[a] += 1  # 出次数
end

# シンク達をキューに入れる
que = Array.new()
(0...deg.size).each do |v|
  que.push v if deg[v] == 0
end

# 探索開始
order = Array.new()
while !que.empty? do
  v = que.shift
  order.push v

  # vへと伸びている頂点を探索
  G[v].each do |nv|
    # 辺 (nv - v)を削除する
    deg[nv] -= 1

    # 新しくシンクになったものがあれば、queに入れる
    que.push nv if deg[nv] == 0
  end
end

# ひっくり返したものが答え
pp order.reverse


