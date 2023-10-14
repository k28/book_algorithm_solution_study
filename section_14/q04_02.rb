#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'stringio'

#
# AtCoder Regular Contest 005 C
# 器物損壊! 高橋くん
# ダイクストラ法でチャレンジ (これだと計算量が多かった)
#

# 無限大を表す値 (ここでは十分大きな値を用いることにする)
INF = 2**60

DEBUG = true # デバッグモードならtrue

SENTINEL = "+"
START    = "s"
GOAL     = "g"
WALL     = "#"
WAY      = "."
MAX      = 2

def debug_print(s)
  pp s if DEBUG
end

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

def calc_point(h, w, width)
  (h * width) + w
end

# __main__

# 入力
#input_str = <<'EOS'
#4 5
#s####
#....#
######
##...g
#EOS

#input_str = <<'EOS'
#10 10
#s.........
##########.
##.......#.
##..####.#.
###....#.#.
######.#.#.
#g##.#.#.#.
####.#.#.#.
####.#.#.#.
##.....#...
#EOS

input_str = <<'EOS'
1 10
s..####..g
EOS

# __main__
# $stdin = StringIO.new(input_str)
$sdtin = STDIN

# グラフを読み込む。 周りを番兵で囲んで処理しやすくします
H, W = gets.chomp.split(' ').map(&:to_i)
G = Array.new(H + 2) { Array.new(W + 2, SENTINEL) }

H.times do |h|
  w = 1
  map = gets.chomp.split('').each do |m|
    G[h + 1][w] = m
    w += 1
  end
end

# debug_print(G)

# グラフとして読み込みます
move = [[1, 0], [-1, 0], [0, -1], [0, 1]]
start = 0
goal = 0
GRAPH = Array.new(H*W) { Array.new() }
H.times do |h|
  W.times do |w|
    point = calc_point(h, w, W)
    current_h = h + 1
    current_w = w + 1
    current_value = G[current_h][current_w]
    start = point if current_value == START
    goal = point if current_value == GOAL
    move.each do |m|
      hp = (current_h) + m[0]
      wp = (current_w) + m[1]
      s = G[hp][wp]
      next if s == SENTINEL
      cost = s == WALL ? 1 : 0
      GRAPH[point].push Edge.new(calc_point(hp - 1, wp - 1, W), cost)
    end
  end
end

# ダイクストラ法
n = H * W # 頂点数
used = Array.new(n, false)
dist = Array.new(n, INF)
dist[start] = 0
n.times do |iter|
  # 使用済みでない頂点のうち、dist値が最小の頂点を探す
  min_dist = INF
  min_v = -1
  n.times do |v|
    if !used[v] and dist[v] < min_dist
      min_dist = dist[v]
      min_v = v
    end
  end

  # もしそのような頂点が見つからなければ終了する
  break if min_v == -1
  
  # min_vを始点とした各辺を緩和する
  GRAPH[min_v].each do |e|
    chmin(dist, e.to, dist[min_v] + e.w)
  end

  used[min_v] = true # min_vを[使用済み]とする
end

#debug_print goal
#debug_print dist[goal]

if dist[goal] <= 2
  print "YES\n"
else
  print "NO\n"
end

