#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'stringio'

#
# AtCoder Begginer Contest 132 E Hopscotch Addict
#

# グラフに対して、頂点sからtに至る3倍の経路があるか探索
# 探索はBFS(Breadth-first search, 幅優先探索)で行う
def search(graph, s, t)
  n = graph.size()

  # グラフ探索のためのデータ構造
  # グラフを3倍にするので、seenを2次元配列にします
  seen = Array.new(n) { Array.new(3, -1)}  # 全ての頂点を未訪問にする
  todo = Array.new()
  
  # 初期条件
  seen[s][0] = 0      # sは探索済み
  todo.push [s, 0]    # todoはsのみを含む状態にする

  # todoが空になるまで探索を行う
  while !todo.empty? do
    cur = todo.shift
    v = cur[0]
    parity = cur[1] 

    # vから辿れる頂点を全て調べる
    list = graph[v]
    list.each do |x|
      xd = (parity + 1) % 3
      if seen[x][xd] == -1
        seen[x][xd] = seen[v][parity] + 1
        todo.push [x, xd]
      end
    end
  end

  if seen[t][0] == -1
    return -1
  else
    # 1回の移動で3回進めるので、3で割った数が実際の移動回数
    return seen[t][0] / 3
  end
end

# __main__

# 入力

input_str = <<'EOS'
4 4
1 2
2 3
3 4
4 1
1 3
EOS

# __main__
# $stdin = StringIO.new(input_str)
$sdtin = STDIN

# 頂点数, 辺数
N, M = gets.chomp.split(' ').map(&:to_i)

# グラフ
G = Array.new(N) { Array.new() }
M.times do
  a, b = gets.chomp.split(' ').map(&:to_i).map{|x| x - 1}
  G[a].push(b)
end

# 始点, 終点
s, t = gets.chomp.split(' ').map(&:to_i).map{|x| x - 1}

result = search(G, s, t)
print result


