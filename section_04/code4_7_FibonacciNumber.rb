#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require '../common/ruby/assert.rb'

#
# 再帰だと計算量が爆発するので、forで行うパターン
#

def fibo(n)
  return 0 if n == 0
  return 1 if n == 1

  a = 0
  b = 1
  (n - 1).times do
    tmp = (a + b)
    a = b
    b = tmp
  end

  b
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
