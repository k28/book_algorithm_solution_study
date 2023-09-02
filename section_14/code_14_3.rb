#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'stringio'

#
# ダイクストラ法 : O(|V|^2) の実装
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
used = Array.new(N, false)
dist = Array.new(N, INF)
dist[s] = 0
N.times do |iter|
  # 使用済みでない頂点のうち、dist値が最小の頂点を探す
  min_dist = INF
  min_v = -1
  N.times do |v|
    if !used[v] and dist[v] < min_dist
      min_dist = dist[v]
      min_v = v
    end
  end

  # もしそのような頂点が見つからなければ終了する
  break if min_v == -1

  # min_v を始点とした各辺を緩和する
  G[min_v].each do |e|
    chmin(dist, e.to, dist[min_v] + e.w)
  end
  used[min_v] = true; # min_v を「使用済み」とする
end

# 結果出力
N.times do |v|
  if dist[v] < INF
    pp dist[v]
  else
    pp "INF"
  end
end

