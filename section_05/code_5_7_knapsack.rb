#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# ナップサップ問題
#

weights = [2, 1, 3, 2, 1, 5]
values  = [3, 2, 6, 1, 3, 85]

@dp = Hash.new {0}

# a, b 大きい方を返します
def chmax(a, b)
  return [a, b].max
end

# i, wを使ったKeyを作成します
def make_key(i, w)
  i.to_s + "-" + w.to_s
end

# dpの内容を表示します
def print_dp_values(vsize, wmax)
  (0...(vsize + 1)).each do |i|
    if i == 0
      print "   "
      (0..wmax).each do |w|
        print "#{'%02d'%w} "
      end
      p ''
    end
    print "#{'%02d'%i} "
    (0..wmax).each do |w|
      str = '%02d'%@dp[make_key(i, w)]
      print "#{str} "
    end
    p ''
  end
end

w_max = weights.sum

(0...values.size).each do |i|
  (0..w_max).each do |w|
    key = make_key i, w
    # i番目の品物を選ぶとき
    i_weight = weights[i]
    i_value = values[i]
    if w - i_weight >= 0
      @dp[make_key(i + 1, w)] = chmax(@dp[make_key(i + 1, w)], @dp[make_key(i, w - i_weight)] + i_value)
    end
    # i番目の品物を選ばない時
    @dp[make_key(i + 1, w)] = chmax(@dp[make_key(i + 1, w)], @dp[key])
  end
end

# print_dp_values values.size, w_max
# pp @dp


