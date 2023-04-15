#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# insersion sort
#

require 'stringio'

def insersion_sort(a)
  a.count.times do |i|
    v = a[i]  # 挿入したい値

    # vを挿入する適切な場所jを探す
    j = i
    while j > 0
      if a[j - 1] > v
        # vより大きいものは1つ後ろにずらす
        a[j] = a[j - 1]
      else
        # v 以下になったら止める
        break
      end
      j -= 1
    end

    # 最後にj版めにvを持ってくる
    a[j] = v
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

insersion_sort(list)
pp list

