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

pp "ok"

