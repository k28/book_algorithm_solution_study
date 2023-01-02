#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require '../common/ruby/assert.rb'

#
# 部分和問題 メモ化で高速化
# メモ化することで計算時間がO(NW)になる
#

@memo = {}

def makeKey(i, w)
  i.to_s + "-" + w.to_s
end

def func(i, w, list)
  if i == 0
    return (w == 0)
  end
  key = makeKey(i, w)
  return @memo[key] if @memo.include? key

  # a[i - 1]を選ばない場合
  if func(i - 1, w, list)
    @memo[key] = true
    return true
  end

  # a[i - 1]を選んだ場合
  if func(i - 1, w - list[i - 1], list)
    @memo[key] = true
    return true
  end

  # どちらもfalseの場合はfalse
  @memo[key] = false
  false
end

# __main__ 

list = [3, 2, 6, 5]
Common::Assert.equal(true,  func(list.length(), 14, list))
@memo.clear()
Common::Assert.equal(true,  func(list.length(), 16, list))
@memo.clear()
Common::Assert.equal(false, func(list.length(), 15, list))

list = [3, 2, 6, 5, 31, 22, 17, 34, 2, 135, 7, 2, 6, 21, 56, 73, 2, 13, 59, 23, 11, 12, 13, 14, 15, 16, 17]
@memo.clear()
Common::Assert.equal(false, func(list.length(), 777, list))

pp "ok"

