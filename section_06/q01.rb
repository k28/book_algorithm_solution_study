#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# 座標圧縮問題
#

def lower_bound(list, key)
  left = 0
  right = list.size

  while (right - left) > 1
    mid = left + ((right - left) / 2)
    if list[mid] > key
      right = mid
    else
      left = mid
    end
  end

  left
end

# __main__

# 入力
a = [12, 43, 7, 15, 9]

# aをソートした (NlogN)
b = a.sort

pp a.map { |v| lower_bound(b, v) }

