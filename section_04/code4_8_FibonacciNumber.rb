#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require '../common/ruby/assert.rb'

#
# 再帰呼び出し + メモ化で高速化する
#

@memo = {}

def fibo(n)
  return @memo[n] if @memo.include? n
  return 0 if n == 0
  return 1 if n == 1

  @memo[n] = fibo(n - 1) + fibo(n - 2)
end

Common::Assert.equal(0, fibo(0))
Common::Assert.equal(1, fibo(1))
Common::Assert.equal(1, fibo(2))
Common::Assert.equal(2, fibo(3))
Common::Assert.equal(3, fibo(4))
Common::Assert.equal(5, fibo(5))
Common::Assert.equal(75025, fibo(25))
Common::Assert.equal(12586269025, fibo(50))

pp "ok"
