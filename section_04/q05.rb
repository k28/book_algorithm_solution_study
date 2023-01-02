#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# 753数の数を数える
# ABC114, Cでチェック済み
#

@total = 0
# 753数の数を返す currentは現在の数値
def calc(max_num, current, flag)
  if current > max_num
    return
  end
  if flag == 7
    @total += 1
  end

  # 7を選んだ場合
  calc(max_num, current * 10 + 7, flag | 0x01)

  # 5を選んだ場合
  calc(max_num, current * 10 + 5, flag | 0x02)

  # 3を選んだ場合
  calc(max_num, current * 10 + 3, flag | 0x04)

end

n = gets

calc(n.to_i, 0, 0)

pp @total
