#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# 虫喰い算の解答を考察する
#
#   2 ?
# x ? ?
# -----
# ? 3 ?
# ? ?
# ? 4 ?


#
# 2 x * y z = として計算する
# 条件
# 2 x * y = ? 3 ?
#
# 全パターンを探索する. パターンにマッチしないものは途中で探索をやめる
#

(1..9).each do |x|
  up = 20 + x
  (1..9).each do |y|
    tmp = (up * y).to_s
    next if tmp.length != 3
    next if tmp[1] != '3'

    (1..9).each do |z|
      result = (up * (z*10 + y)).to_s
      next if result.length != 3
      next if result[1] != '4'
      pp "result is 2#{x} x #{z}#{y} = #{result}"
    end
  end
end


