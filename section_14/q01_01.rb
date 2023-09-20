#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# Educational DP Contest DP
# G - Longest Path
#

require 'stringio'

# 緩和を実施する関数
def chmin(g, a, b)
  if (g[a] > b)
    g[a] = b
    return true
  end

  return false
end

def chmax(a, b)
  if (a < b)
    return b
  end
  return a
end


DP = Array.new(100100)
def rec(v)
  return DP[v] if (DP[v] != -1) # 既に更新済み

  res = 0
  G[v].each do |nv|
    res = chmax(res, rec(nv) + 1)
  end

  pp DP
  DP[v] = res
end


# 入力
input_str = <<'EOS'
4 5
1 2
1 3
3 2
2 4
3 4
EOS

# __main__
$stdin = StringIO.new(input_str)
# $sdtin = STDIN

N, M = gets.chomp.split(' ').map(&:to_i)

# グラフの定義と読み込み(グラフはListの2次元配列)
G = Array.new(N) { Array.new() }

M.times do
  a, b = gets.chomp.split(' ').map(&:to_i)
  # 有効グラフ
  G[a - 1].push(b - 1)
end

# 初期化
N.times do |v|
  DP[v] = -1
end

# 全ノードを一通り更新しながら答えを求める
res = 0
N.times do |v|
  res = chmax(res, rec(v))
end

pp res


