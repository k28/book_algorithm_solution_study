#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# Union-Findを用いて無向グラフの連結成分の個数を求める
#

require 'stringio'

class UnionFind
  attr_reader :par, :siz

  def initialize(n)
    @par = Array.new(n, -1)
    @siz = Array.new(n, 1)
  end

  # 根を求める
  def root(x)
    return x if @par[x] == -1

    @par[x] = root(@par[x])
  end

  # xとyが同じグループに属するかどうか (根が一致するかどうか)
  def issame(x, y)
    return root(x) == root(y)
  end

  # xを含むグループとyを含むグループを併合する
  def unite(x, y)
    # x, yをどれぞれ根まで移動する
    x = root(x)
    y = root(y)

    # すでに同じグループの場合は何もしない
    return false if x == y

    # union by size (y側のサイズが小さくなるようにする
    if @siz[x] < @siz[y]
      t = y
      y = x
      x = t
    end

    # yをxの子とする
    @par[y] = x
    @siz[x] += @siz[y]
    return true
  end

  # xを含むグループのサイズ
  def size(x)
    return @siz[root(x)]
  end

  def to_string()
    "par:#{@par} siz:#{@siz}"
  end

end

# 入力
input_str = <<'EOS'
10 7
0 4
0 3
3 7
3 8
1 5
2 6
6 9
EOS

# __main__
$stdin = StringIO.new(input_str)
#$sdtin = STDIN

N, M = gets.chomp.split(' ').map(&:to_i)

# Union-Findを要素数Nで初期化
uf = UnionFind.new(N)

# グラフの定義と読み込み(グラフはListの2次元配列)
(M).times do
  a, b = gets.chomp.split(' ').map(&:to_i)
  # aを含むグループとbを含むグループを併合する
  uf.unite(a, b)
end

# 集計
res = 0
(N).times do |x|
  res += 1 if uf.root(x) == x
end

pp res


