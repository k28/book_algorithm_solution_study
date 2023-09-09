#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'stringio'
require '../common/ruby/priority_queue.rb'

#
# ダイクストラ法 : ヒープを用いるパターン
#

# 無限大を表す値 (ここでは十分大きな値を用いることにする)
INF = 2**60

class Edge
  # to: 隣接頂点番号, w: 重み
  attr_reader :to, :w
  
  def initialize(to, w)
    @to = to
    @w = w
  end
end

# 緩和を実施する関数
def chmin(g, a, b)
  if (g[a] > b)
    g[a] = b
    return true
  end

  return false
end


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

# 頂点数, 辺数, 始点
N, M, s = gets.chomp.split(' ').map(&:to_i)

# グラフ
G = Array.new(N) { Array.new() }
M.times do
  a, b, w = gets.chomp.split(' ').map(&:to_i)
  G[a].push Edge.new(b, w)
end

# ダイクストラ法
dist = Array.new(N, INF)
dist[s] = 0

# (d[v], v)のペアを要素としたヒープを作成する
# 小さい順に返すように指定します
que = Common::PriorityQueue.new([], lambda {|x, y| x[0] <= y[0]})
que.push([dist[s], s])

# ダイクストラ法の反復を開始
while !que.empty?
  # v: 使用済みでない頂点のうち、d[v]が最小の頂点
  # d: vに対するキー値
  v = que.top()[1]
  d = que.top()[0]
  que.pop()

  # d > dist[v] は(d, v) がゴミであることを意味します
  next if d > dist[v]

  # 頂点vを始点とした各辺を緩和
  G[v].each do |e|
    if (chmin(dist, e.to, dist[v] + e.w))
      # 更新があるならヒープに新しく挿入します
      que.push([dist[e.to], e.to])
    end
  end
end

# 結果出力
N.times do |v|
  if dist[v] < INF
    pp dist[v]
  else
    pp "INF"
  end
end

