#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# トリボナッチ数列
#

def tribonacci(n)
  return 0 if n == 0
  return 0 if n == 1
  return 1 if n == 2
  return tribonacci(n - 1) + tribonacci(n - 2) + tribonacci(n - 3)
end

(0..10).each do |i|
  pp tribonacci(i)
end

