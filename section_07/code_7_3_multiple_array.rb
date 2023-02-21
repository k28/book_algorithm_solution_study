#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# AtCoder Grand Contest 009 A Multiple Array
# 貧欲法
#

#N = 3
#a = [3, 2, 9]
#b = [5, 7, 4]

N = gets.to_i
a = []
b = []
(0...N).each do |i|
  s = gets.split(" ").map{|x| x.to_i }
  a.push s[0]
  b.push s[1]
end

# aの後ろからbの等数倍になるように調整していく
sum = 0

(0...N).reverse_each do |i|
  # 今までの分をaに加算する
  v = a[i] + sum
  # aに幾つ加算すればb[i]の等数倍になるか算出して加算する
  amari = (v % b[i])
  d = amari == 0 ? 0 : b[i] - amari
  sum += d
end

pp sum

