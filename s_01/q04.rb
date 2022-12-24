#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# 覆面算を解く
#
#         ? ? ? ? ? ?
#       x     w v z y
#      --------------
#         6 6 ? ? ? ?
#       6 ? ? ? ? ?
#   ? ? 6 6 6 ? ?
#   ? ? 6 ? ? 6
#   -----------------
# ? ? ? ? 6 6 ? ? ? ? 
#

def search_z(x)
end

# x * y の結果が66???? になるxが探索範囲になる
# x * z の結果が6????? になるzが探索範囲になる..以下同様に絞り込んで探索をする
(100000...999999).each do |x|
  (1...9).each do |y|
    a1 = (x * y).to_s
    next if a1.length != 6
    next if a1[4] != '6'
    next if a1[5] != '6'
    (1..9).each do |z|
      a2 = (x * z).to_s
      next if a2.length != 6
      next if a2[5] != '6'
      (1..9).each do |v|
        a3 = (x * v).to_s
        next if a3.length != 7
        next if a3[4] != '6'
        next if a3[3] != '6'
        next if a3[2] != '6'
        (1..9).each do |w|
          a4 = (x * w).to_s
          next if a4.length != 6
          next if a4[0] != '6'
          next if a4[3] != '6'
          wvzy = "#{w}#{v}#{z}#{y}".to_i
          result = (x * wvzy).to_s
          #pp "#{x} * #{wvzy} = #{result}"
          next if result.length != 10
          next if result[4] != '6'
          next if result[5] != '6'
          pp "answer = #{x} x #{wvzy} = #{result}" 
        end
      end
    end
  end
end

