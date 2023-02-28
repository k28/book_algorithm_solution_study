#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# AtCoder Beginner Contest 131 D - Megalomania
#

#N = 5
#task_list = [[2, 4], [1, 9], [1, 8], [4, 9], [3, 12]]

task_list = []
N = gets.to_i
N.times do
  task = gets.split(" ").map {|x| x.to_i }
  task_list.push(task)
end

# task_listを締切時間順にソート
task_list.sort! {|a, b| a[1] <=> b[1]}

ok = true
t = 0       # 仕事をする時間
(0...N).each do |i|
  task = task_list[i]
  if t + task[0] <= task[1]
    t += task[0]
  else
    # 締切を過ぎてしまう
    ok = false
    break
  end
end

print ok ? "Yes" : "No"

