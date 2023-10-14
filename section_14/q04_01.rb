#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'stringio'

#
# AtCoder Regular Contest 005 C
# 器物損壊! 高橋くん
# このコードではAC取れません...
#

DEBUG = false # デバッグモードならtrue

SENTINEL = "+"  # 番兵
START    = "s"
GOAL     = "g"
WALL     = "#"
WAY      = "."
MAX      = 2

def debug_print(s)
  pp s if DEBUG
end

MOVE = [[1, 0], [-1, 0], [0, 1], [0, -1]]

def walk(h, w, cp)
  if DP[h][w] <= cp
    return
  end
  DP[h][w] = cp
  debug_print("#{h}, #{w}, #{cp}")

  MOVE.each do |m|
    nh = h + m[0]
    nw = w + m[1]
    np = G[nh][nw]
    if np == WAY || np == START || np == GOAL
      # そのまま進める
      walk(nh, nw, cp)
    elsif np == WALL && cp < MAX
      # 壁を破壊して進む
      walk(nh, nw, cp + 1)
    end
  end
end

# __main__

# 入力
input_str = <<'EOS'
4 5
s####
....#
#####
#...g
EOS

# __main__
# $stdin = StringIO.new(input_str)
$sdtin = STDIN

# グラフを読み込む。 周りを番兵で囲んで再帰処理をしやすくします
H, W = gets.chomp.split(' ').map(&:to_i)
G = Array.new(H + 2) { Array.new(W + 2, SENTINEL)}
DP = Array.new(H + 2) { Array.new(W + 2, MAX + 1)}

H.times do |h|
  w = 1
  map = gets.chomp.split('').each do |m|
    START_POINT = [h + 1, w] if m == START
    GOAL_POINT  = [h + 1, w] if m == GOAL

    G[h + 1][w] = m
    w += 1
  end
end

debug_print(G)
debug_print(START_POINT)
debug_print(GOAL_POINT)

walk(START_POINT[0], START_POINT[1], 0)
debug_print(DP)

goal_point = DP[GOAL_POINT[0]][GOAL_POINT[1]]
if goal_point <= MAX
  print "YES\n"
else
  print "NO\n"
end

