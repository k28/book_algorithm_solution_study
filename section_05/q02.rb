#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require '../common/ruby/assert.rb'

#
# 部分和問題 (メモ化して高速化)
#

@memo = {}

def make_key(w, i)
  return "#{w}-#{i}"
end

def walk(w, i, a)
  return true  if w == 0
  return false if a.length == i
  key = make_key(w, i)
  return @memo[key] if @memo.include? key

  # iを選択する場合
  if walk(w - a[i], i + 1, a)
    @memo[key] = true
    return true
  end

  # iを選択しない場合
  if walk(w, i + 1, a)
    @memo[key] = true
    return true
  end
  
  @memo[key] = false
  return false
end

# Wにする事ができるか解く問題
def check(n, w, a)
  a_max = a.sum

  if w > a_max
    return "false"
  end

  # 再起的に確認
  return "true" if walk(w, 0, a)

  # matchしなかった
  "false"
end


Common::Assert.equal("true",  check(5, 10, [1, 2, 4, 5, 11]))
# memoを初期化
@memo = {}
Common::Assert.equal("false", check(4, 10, [1, 5, 8, 11]))

