#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# コイン問題を解く貧欲法
#

# コインの金額
value = [500, 100, 50, 10, 5, 1]

# 入力
x = 1234

result = 0
(0...value.size).each do |i|
  add = x / value[i]
  x -= value[i] * add
  result += add
end

pp result

