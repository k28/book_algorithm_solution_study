#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require '../common/ruby/assert.rb'

#
# 配列から目的の値を探索する2分探索法
#

@N = 8
@a = [3, 5, 8, 10, 14, 17, 21, 39]

def binary_search(key)
  left = 0
  right = @a.size - 1;

  while right >= left
    mid = left + (right - left) / 2

    return mid if @a[mid] == key

    if @a[mid] > key
      right = mid - 1
    elsif @a[mid] < key
      left = mid + 1
    end
  end

  return -1
end

Common::Assert.equal(3, binary_search(10))
Common::Assert.equal(0, binary_search(3))
Common::Assert.equal(7, binary_search(39))

Common::Assert.equal(-1, binary_search(-100))
Common::Assert.equal(-1, binary_search(9))
Common::Assert.equal(-1, binary_search(100))

