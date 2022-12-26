#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require '../common/ruby/assert.rb'

#
# ユークリッドの互助法 (Euclidean Algolithm)
#

def GCD(m, n)
  # ベースケース
  return m if (n == 0)

  # 再帰呼び出し
  return GCD(n, m % n)
end

# __main__

Common::Assert.equal(3, GCD(51, 15))
Common::Assert.equal(6, GCD(12, 18))
Common::Assert.equal(9, GCD(18, 27))

pp "ok"

