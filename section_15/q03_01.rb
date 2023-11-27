#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# ACM-ICPC Asia 2014 F There is No Alternative
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
4 4
1 2 3
1 3 5
2 3 3
2 4 3
EOS

# __main__
$stdin = StringIO.new(input_str)
# $sdtin = STDIN

# 頂点数と辺数
N, M = gets.chomp.split(' ').map(&:to_i)

edges = Array.new(M)
M.times do |i|
  u, v, w = gets.chomp.split(' ').map(&:to_i)
  edges[i] = [w, [u - 1, v - 1]]
end

# 各辺を辺の重荷が小さい順にソートする
edges.sort_by! { |item| item[0] }

# クラスカル法でMSTを求める
# id番目の辺は無視する
def calc(n, m, edges, mst, id)
  res = 0
  uf = UnionFind.new(n)
  m.times do |i|
    next if i == id
    w = edges[i][0]
    u = edges[i][1][0]
    v = edges[i][1][1]

    # 辺(u, v)の追加によってサイクルが形成されるときは追加しない
    next if (uf.issame(u, v))

    # 辺(u, v)を追加する
    res += w
    mst.push(i)
    uf.unite(u, v)
  end

  if mst.size != n - 1
    # MSTにならない場合
    1 << 60
  else
    res
  end
end

# まず普通にMSTを求める
mst = Array.new()
base = calc(N, M, edges, mst, -1)

# MSTに含まれる辺を除いてMSTを求める
result = Array.new()
mst.each do |id|
  result.push edges[id][0] if base < calc(N, M, edges, [], id)
end

print "#{result.size} #{result.sum}"

