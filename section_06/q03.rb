#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# ダーツ
#

def lower_bound(list, key)
  left = -1
  right = list.size

  while left + 1 < right
    mid = left + ((right - left) / 2)
    if list[mid] >= key
      right = mid
    else
      left = mid
    end
  end

  right
end

def upper_bound(list, key)
  left = -1
  right = list.size

  while left + 1 < right
    mid = left + ((right - left) / 2)
    if list[mid] > key
      right = mid
    else
      left = mid
    end
  end

  right
end

#N = 3
#M = 20
#a = [16, 11, 2]

l = gets.split(" ").each.map {|x| x.to_i }
N = l[0]
M = l[1]
a = [0]
N.times do
  a.push(gets.to_i)
end

# 選ばない場合を考えやすくするために0を入れておく
a.push(0)

s = []
# aから重複を許して2つ選んだ和を求める
(0...N+1).each do |i|
  (0...N+1).each do |j|
    s.push(a[i] + a[j])
  end
end

# sをソート
s.sort!

max_point = 0
(0...s.size).each do |i|
  expect = M - s[i]
  v = upper_bound(s, expect)
  v -= 1
  next if v < 0

  point = s[i] + s[v]
  if point <= M && point > max_point
    max_point = point
  end
end

 pp max_point

