#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# AtCoder Regular Contest 092 C 2D Plane 2N Points.
#

# xについてソートします
def compare(a, b)
  return a[0] <=> b[0]
end

# 選択可能な物を探します
def pickup(c, b, s)
  #bよりも大きいcの中で、b[1]が最大になるものを選択します
  pick = -1
  yDiff = -1
  (0...b.size).each do |i|
    next if s[i]  # 選択済みの物はスキップ

    if c[0] > b[i][0] && c[1] > b[i][1] && yDiff < b[i][1]
      pick = i
      yDiff = b[i][1]
    end
  end

  if pick >= 0
    s[pick] = true
    return true
  end

  return false
end

#N = 3
#a = [[2, 0], [3, 1], [1, 3]]
#b = [[4, 2], [0, 4], [5, 5]]

N = gets.to_i
a = []
b = []
(0...N).each do |i|
  s = gets.split(" ").map {|x| x.to_i}
  a.push([s[0], s[1]])
end
(0...N).each do |i|
  s = gets.split(" ").map {|x| x.to_i}
  b.push([s[0], s[1]])
end

# a, bをそれぞれソートします
a.sort! {|x, y| compare(x, y)}
b.sort! {|x, y| compare(x, y)}

s = Array.new(N, false) # 選択済みのindex

ans = 0
(0...N).each do |i|
  if pickup(b[i], a, s)
    ans += 1
  end
end

pp ans

