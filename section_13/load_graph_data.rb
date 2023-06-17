#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# グラフデータの読み込み
#

require 'stringio'

# 入力
input_str = <<'EOS'
8 13
4 1
4 2
4 6
1 3
1 6
2 5
2 7
6 7
3 0
3 7
7 0
0 5
EOS

# __main__
$stdin = StringIO.new(input_str)
#$sdtin = STDIN

N, M = gets.chomp.split(' ').map(&:to_i)

# グラフの定義と読み込み(グラフはListの2次元配列)
G = Array.new(N) { Array.new() }
(M - 1).times do
  a, b = gets.chomp.split(' ').map(&:to_i)
  G[a].push(b)
end

