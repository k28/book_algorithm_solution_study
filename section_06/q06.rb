#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# AtCoder Beginner Contest 026 D
#
# 二分探索で範囲を絞り込みながら最適な値を見つける
# right - left の差が1.0e-11ぐらいで求める精度になる
#

A = 53
B = 82
C = 49

#s = gets.split(" ").map{|x| x.to_i }
#A = s[0]
#B = s[1]
#C = s[2]

def ball_position(t)
  return (A * t) + B * Math::sin(C * t * Math::PI)
end

left = 0.0
right = 200

while right - left > 1.0e-11
  mid = left + (right - left) / 2
  if ball_position(mid) >= 100.0000000
    right = mid
  else
    left = mid
  end

  #pp "#{ball_position(mid)} #{left} #{right}"
  #sleep 0.3
end

pp right
#pp ball_position(left)
#pp ball_position(right)
