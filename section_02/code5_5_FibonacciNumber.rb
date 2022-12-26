#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require '../common/ruby/assert.rb'

#
# フィボナッチ数列を求める
#

def fibo(n)
  return 0 if n == 0
  return 1 if n == 1

  return fibo(n - 1) + fibo(n -2)
end

Common::Assert.equal(0, fibo(0))
Common::Assert.equal(1, fibo(1))
Common::Assert.equal(1, fibo(2))
Common::Assert.equal(2, fibo(3))
Common::Assert.equal(3, fibo(4))
Common::Assert.equal(5, fibo(5))

pp "ok"

