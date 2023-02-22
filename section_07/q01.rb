#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# ペアを作成する
#

N = 4
a = [1, 3, 5, 7]
b = [100, 3, 1, 5]

a.sort!
b.sort!

# aの一番小さいものから、bの中で組めるものとペアを作っていく
# bもソートしてなくてOKっぽいけど、ソートしてないと組めないパターンがある

a_index = 0
(0...N).each do |j|
  a_index += 1 if a[a_index] < b[j]
end

pp a_index


