#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# 年齢当てゲーム
#

pp "Start Game!"

# Aさんの数の候補を表す区間を, [left, right)と表す
left = 20
right = 36

# Aさんの数を1つに絞れないうちは繰り返す

while right - left > 1
  mid = right + (left - right) / 2

  pp "Is the age less than #{mid}? (yes / no)"
  ans = gets.chomp
  
  if ans == "yes"
    right = mid
  else
    left = mid
  end
end

pp "The age is #{left}! "

