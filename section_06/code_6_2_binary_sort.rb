#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# 一般化した二分探索法の基本形
#

# x が条件を満たすかどうか
def P(x)
  # 仮に10以上ならtrueを返すようにする
  return true if x >= 7
end

def binary_search(l, r)
  left = l
  right = r

  while right - left > 1
    mid = left + (right - left) / 2
    # pp "#{left} #{mid} #{right}"
    if P(mid)
      right = mid
    else
      left = mid
    end
  end

  right
end

pp binary_search(-10, 100)

