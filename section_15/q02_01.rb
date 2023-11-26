#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# クラスカル法の実装
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

  def to_s()
    "par:#{@par} siz:#{@siz}"
  end

end

require 'stringio'

# 入力
input_str = <<'EOS'
8 12
0 7 3
0 5 6
0 3 5
1 4 4
1 6 3
1 3 8
2 4 9
2 7 5
2 5 10
3 7 6
4 6 2
6 7 7
EOS

# __main__
$stdin = StringIO.new(input_str)
#$sdtin = STDIN

# 頂点数と辺数
N, M = gets.chomp.split(' ').map(&:to_i)

edges = Array.new(M)
M.times do |i|
  u, v, w = gets.chomp.split(' ').map(&:to_i)
  edges[i] = [w, [u, v]]
end

# メディアンの位置を算出
# MSTの辺の数は頂点の数-1になるので、その中央
median = (N - 1) / 2

# 各辺を辺の重荷が小さい順にソートする
edges.sort_by! { |item| item[0] }

# クラスカル法
res = 0
num = 0
uf = UnionFind.new(N)
M.times do |i|
  w = edges[i][0]
  u = edges[i][1][0]
  v = edges[i][1][1]

  # 辺(u, v)の追加によってサイクルが形成されるときは追加しない
  next if (uf.issame(u, v))

  # 辺(u, v)を追加する
  uf.unite(u, v)

  # メディアンに到達
  num += 1
  if num == median
    res = w
    break
  end
end

pp res

