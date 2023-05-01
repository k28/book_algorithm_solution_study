#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#__ main __

# 入力 (テスト)
input_str = <<'EOS'
4 30
6 18
2 5
3 10
7 9
EOS

#$stdin = StringIO.new(input_str)
$sdtin = STDIN

N, M = gets().split(' ').map(&:to_i)
list = []
N.times do
  list.push gets().split(' ').map(&:to_i)
end

# リストをソート
list.sort! { |a, b| a[0] <=> b[0] }

# listの先頭から 合計がMになるまで購入していきます
total = 0
charge = 0
list.each do |l|
  price = l[0]
  count = l[1]
  can_buy_count = [count, M - total].min
  #pp "Buy #{price} * #{can_buy_count} mony=#{price * can_buy_count}"
  charge += price * can_buy_count
  total += can_buy_count

  break if total == M
end

pp charge

