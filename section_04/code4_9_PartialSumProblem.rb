#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require '../common/ruby/assert.rb'

#
# 部分和問題
#

def func(i, w, list)
  if i == 0
    return (w == 0)
  end

  # a[i - 1]を選ばない場合
  return true if func(i - 1, w, list)

  # a[i - 1]を選んだ場合
  return true if func(i - 1, w - list[i - 1], list)

  # どちらもfalseの場合はfalse
  false
end

# __main__ 

list = [3, 2, 6, 5]
Common::Assert.equal(true,  func(list.length(), 14, list))
Common::Assert.equal(true,  func(list.length(), 16, list))
Common::Assert.equal(false, func(list.length(), 15, list))

# 計算に数秒かかる O(2^N)の限界
# list = [3, 2, 6, 5, 31, 22, 17, 34, 2, 135, 7, 2, 6, 21, 56, 73, 2, 13, 59, 23, 11, 12, 13, 14, 15, 16, 17]
# Common::Assert.equal(false, func(list.length(), 777, list))

pp "ok5"

