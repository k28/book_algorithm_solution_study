#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'stringio'

#
# ベルマン・フォード法の実装
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
6 12 0
0 1 3
0 3 100
1 3 57
1 4 -4
1 2 50
2 3 -10
2 4 -5
2 5 100
3 1 -5
4 2 57
4 3 25
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

# ベルマン・フォード法
exist_negative_cycle = false
dist = Array.new(N, INF)
dist[s] = 0

N.times do |iter|
  update = false # 更新が発生したか表すフラグ
  N.times do |v|
    # dist[v] = INF の時は頂点vからの緩和を行わない
    next if dist[v] == INF

    G[v].each do |e|
      # 緩和処理を行い、更新されたらupdateをtrueにする
      update = true if chmin(dist, e.to, dist[v] + e.w)
    end
  end

  # 更新が行われなかったら、すでに最短経路が求められている
  break if update == false

  # N回目の反復で更新が行われたら、負閉路をもつ
  exist_negative_cycle = true if (iter == N - 1 && update)
end

# 結果出力
if exist_negative_cycle
  pp "NEGATIVE CYCLE"
else
  N.times do |v|
    if dist[v] < INF
      pp "#{v} : #{dist[v]}"
    else
      pp "#{v} : INF"
    end
  end
end


