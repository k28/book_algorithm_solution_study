#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# Bucket Sort
#

# ここでは配列の値は100,000未満とする
MAX = 100_000

def bucket_sort(a)
  n = a.count()
  
  # 各要素の個数をカウントする
  # num[v] = vの個数
  num = Array.new(MAX, 0)
  a.each do |i|
    num[i] += 1
  end

  # numの総和をとる
  # sum[v] = v以下の値の個数
  # 値 a[i] が全体の中で何番目に小さいか求める
  sum = Array.new(MAX, 0)
  i = 1
  while i < MAX
    sum[i] = sum[i - 1] + num[i]
    i += 1
  end
  
  # sumを元にソート処理
  # a2: aをソートしたもの
  a2 = Array.new(n, 0)
  i = n - 1
  while i >= 0
    a2[sum[a[i]] - 1] = a[i]
    i -= 1
  end

  a2
end

#__ main __

# 入力 (テスト)
input_str = <<'EOS'
7
8
1
3
5
7
4
9
EOS

$stdin = StringIO.new(input_str)
# $sdtin = STDIN

N = gets().to_i
list = []
N.times do
  list.push gets().to_i
end

list = bucket_sort(list)
pp list


