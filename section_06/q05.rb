#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# AtCoder Regular Contest 037 C
# 億マス計算
#

def lower_bound(list, key)
  left = -1
  right = list.size

  while left + 1 < right
    mid = left + ((right - left) / 2)
    if list[mid] >= key
      right = mid
    else
      left = mid
    end
  end

  right
end

def upper_bound(list, key)
  left = -1
  right = list.size

  while left + 1 < right
    mid = left + ((right - left) / 2)
    if list[mid] > key
      right = mid
    else
      left = mid
    end
  end

  right
end

s = gets.split(" ").map{|x| x.to_i }
#N = 2
#K = 3
#a = [2, 3]
#b = [3, 5]

N = s[0]
K = s[1]
a = gets.split(" ").map{|x| x.to_i }
b = gets.split(" ").map{|x| x.to_i }

# aを固定して、 [b]のうち、 x/a[i] のものが何個あるかを調べる

# bをソート
b.sort!

# 判定関数
# aを固定して、x/a[i]を満たすパターンがK個以上存在するか調べる
# a:配列, b:配列, x: 目的の値 (a*bがK個以上存在するか調べる)
def check(a, b, x)
  cnt = 0
  (0...N).each do |i|
    cnt += upper_bound(b, x / a[i])
  end
  
  return cnt >= K
end

# 二分探索
left = 0
right = 1 << 60 # 実際には a x b の最大値でOK
while (right - left) > 1
  mid = left + (right - left) / 2
  if check(a, b, mid)
    right = mid
  else
    left = mid
  end
end

pp right

