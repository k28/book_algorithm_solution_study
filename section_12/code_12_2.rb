#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

# 配列aの区間(left, right]をソートする
# [left, right)はleft, left+1 ... right -1 番目を表す
def merge_sort(a, left, right)
  return if right - left == 1
  mid = left + (right - left) / 2

  # 左半分をソート
  merge_sort(a, left, mid)

  # 右半分をソート
  merge_sort(a, mid, right)

  # 一旦左と右のソート結果をコピーして右の結果は逆転して連結しておく
  lList = a[left...mid]
  rList = a[mid...right]
  buf = lList + rList.reverse()

  # 併合する
  index_left = 0
  index_right = buf.size() - 1
  i = left
  while i < right
    if buf[index_left] <= buf[index_right]
      a[i] = buf[index_left]
      index_left += 1
    else
      a[i] = buf[index_right]
      index_right -= 1
    end

    i += 1
  end
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

merge_sort(list, 0, list.size() - 1)
pp list

