#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# Heap sort
#

# i番目の頂点を根とする部分木について、ヒープ条件を満たすようにする
# aのうち、0番目からn-1番目までの部分a[0:n]についてのみ考える
def heapify(a, i, n)
  child1 = i * 2 + 1    # 左の子供
  return if child1 >= n # 子供がない時は終了
  
  # 子供同士を比較
  child1 += 1 if (child1 + 1 < n) && (a[child1 + 1] > a[child1])
  
  return if a[child1] <= a[i] # 逆転がなかったら終了

  # swap
  swap_list_value(a, child1, i)
  
  # 再起的に
  heapify(a, child1, n)
end

def heap_sort(a)
  n = a.count()

  # ステップ1: 全体をヒープにする
  i = (n / 2) - 1
  while i >= 0
    heapify(a, i, n)
    i -= 1
  end

  # ステップ2: ヒープから1つづつ最大値をpopする
  i = n - 1
  while i > 0
    swap_list_value(a, 0, i)  # ヒープの最大値を左に詰める
    heapify(a, 0, i)          # ヒープの最大値をiにする
    i -= 1
  end

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

heap_sort(list)
pp list

