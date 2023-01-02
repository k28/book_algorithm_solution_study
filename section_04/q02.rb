#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# トリボナッチ数列 (メモ化で高速化)
#

@memo = {}

def tribonacci(n)
  return @memo[n] if @memo.include? n
  return 0 if n == 0
  return 0 if n == 1
  return 1 if n == 2
  @memo[n] = tribonacci(n - 1) + tribonacci(n - 2) + tribonacci(n - 3)
end

(0..50).each do |i|
  pp tribonacci(i)
end


