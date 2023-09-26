#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'stringio'

#
# AtCoder Beginner Contest 061 - D Score Attack
#
# ベルマンフォード法 で最短経路ではなくて、最長経路を求める。
# (重みにマイナスを掛けることで、最短経路問題に置き換えて解くことができる)
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
3 3
1 2 4
2 3 3
1 3 5
EOS

# __main__
# $stdin = StringIO.new(input_str)
$sdtin = STDIN

# 頂点数, 辺数, 始点
N, M = gets.chomp.split(' ').map(&:to_i)
s = 0

# グラフ
G = Array.new(N) { Array.new() }
M.times do
  a, b, w = gets.chomp.split(' ').map(&:to_i)
  # 辺の重みに-1を掛けて最短経路問題に置き換える
  G[a - 1].push Edge.new(b - 1, -w)
end

# ベルマン・フォード法
exist_negative_cycle = false
dist = Array.new(N, INF)
dist[s] = 0
ngtv = Array.new(N, false)

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
end

# もう一度同じことをして最終的な結果が同じかチェックする(変わっていたら負閉路が存在する)
max = dist[N - 1]
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
end

# 最終結果が違う場合は負閉路が存在している
exist_negative_cycle = max != dist[N - 1]

# 結果出力
if exist_negative_cycle
  print "inf"
else
  pp -dist[N - 1]
  # N.times do |v|
  #   if dist[v] < INF
  #     pp "#{v} : #{dist[v]}"
  #   else
  #     pp "#{v} : INF"
  #   end
  # end
end
