#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# BFSで迷路を解く
#

require 'stringio'

START = 'S'
GOAL = 'G'
WAY = '.'
WALL = '#'

# 探索する方向
STEP = [[0, 1], [0, -1], [1, 0], [-1, 0]]

class Point
  attr_reader :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end
end

# 幅優先探索でゴールまでの最短経路を求めます
def walk(graph, start)
  h = graph.length
  w = graph[0].length
  step = 0

  # グラフ探索のためのデータ構造
  seen = Array.new(h) { Array.new(w, -1)}
  todo = Array.new()

  todo.push start
  seen[start.y][start.x] = 0
  
  # todoが空になるか、ゴールに到達するまで探索を行う
  while !todo.empty? do
    v = todo.shift

    # vから辿れる頂点を調べる
    STEP.each do |step|
      next_v = Point.new(v.x + step[0], v.y + step[1])
      # グラフの範囲外と、既に訪問済みの場合は何もしない
      next if next_v.x < 0 || w <= next_v.x
      next if next_v.y < 0 || h <= next_v.y
      next if seen[next_v.y][next_v.x] > -1
      # 訪問済みにする
      seen[next_v.y][next_v.x] = seen[v.y][v.x] + 1

      # 現在の位置を調べます
      obj = graph[next_v.y][next_v.x]
      # 壁なら行き止まりなのでこれ以上探索しない
      next if obj == WALL
      # ゴールだったので処理をやめる
      return seen[next_v.y][next_v.x] if obj == GOAL
      # 道なので次を探索する
      todo.push next_v
    end
    
    # pp todo
    # print_seen seen
  end

  # ここまできたら、ゴールなかったってこと(そんなことある？)
  -1
end

def print_seen(graph)
  graph.each do |y|
    y.each do |x|
      print "%2d " % x
    end
    print "\n"
  end
  print "---------------------\n"
end

# 入力
input_str = <<'EOS'
8 8
.#....#G
.#.#....
...#.##.
#.##...#
...###.#
.#.....#
...#.#..
S.......
EOS

# __main__
$stdin = StringIO.new(input_str)
#$sdtin = STDIN

H, W = gets.chomp.split(' ').map(&:to_i)
graph = Array.new(H) { Array.new() }
start = Point.new(0, 0)
H.times do |y|
  s = gets.chomp
  s.length.times do |x|
    obj = s[x]
    graph[y].push obj
    if obj == START
      start = Point.new(x, y)
    end
  end
end

# pp graph
# pp start

pp walk(graph, start)

