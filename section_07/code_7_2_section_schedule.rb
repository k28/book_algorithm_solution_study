#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# 区間スケジューリング問題 (貧欲法)
#

#N = 3
#a = [[1, 5], [4, 6], [6, 8]]
N = gets.to_i
a = Array.new(N) { Array.new(2) }
(0...N).each do |i|
  s = gets.split(" ").map{|x| x.to_i }
  a[i][0] = s[0]
  a[i][1] = s[1]
end

# aを終端時刻が早い順にソートします
a.sort! {|a, b| a[1] <=> b[1]}

res = 0
current_end_time = 0
(0...N).each do |i|
  # 最後に選んだ区間と被るものは除く
  next if a[i][0] < current_end_time

  res += 1
  current_end_time = a[i][1]
end

pp res


