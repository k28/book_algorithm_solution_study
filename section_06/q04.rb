#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# POJ No. 2456 Aggressive cows
#
# 戦略. x以上の距離にすることができるか? を解く問題として、2分探索する
#

N = 5
M = 3
a = [1, 2, 8, 4, 9]
# ソートされていないので、ソートする
a.sort!

# 最大値
MAX = a.inject(:+)

left = 0
right = MAX
while (right - left) > 1
  mid = left + (right - left) / 2
  # 一番端の小屋は選択する(必ず選ぶことになる)
  count = 1
  prev = 0
  (1...N).each do |i|
    if a[i] - a[prev] >= mid
      prev = i
      count += 1
    end
  end

  if count >= M
    # 選択できた
    left = mid
  else
    # 選択できない
    right = mid
  end
  pp "#{mid} #{count} #{left} : #{right}"
end

 pp left

