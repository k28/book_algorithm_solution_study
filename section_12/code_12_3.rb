#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# Quick Sort
# In placeなソート. 大抵の場合高速
# Pivotの選択をランダムにする事で最悪なデータをソートする時にもO(NlogN)の計算時間にする事が可能
#

# 配列aの区間[left, right)をソートする
# [left, right)は left, left+1, left+2 ... right-1 を表す
def quick_sort(a, left, right)
  return if ((right - left) <= 1)

  pivot_index = (left + right) / 2  # Pivotは中間値とします
  pivot = a[pivot_index]
  swap_list_value(a, pivot_index, right - 1)  # pivot と 右端をswap

  i = left  # iは左詰されたpivot未満要素の右端を返す
  j = left
  while j < right - 1
    if a[j] < pivot
      swap_list_value(a, i, j)
      i += 1
    end
    j += 1
  end
  swap_list_value(a, i, right - 1)   # pivotを適切な位置に挿入

  # 再起的に解く
  quick_sort(a, left, i)
  quick_sort(a, i + 1, right)
end

def swap_list_value(a, left, right)
  tmp = a[left]
  a[left] = a[right]
  a[right] = tmp
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

quick_sort(list, 0, list.size() - 1)
pp list

