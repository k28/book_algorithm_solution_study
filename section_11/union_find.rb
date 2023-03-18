#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require '../common/ruby/assert.rb'

#
# Union-Find をRubyで実装してみる
#

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


uf = UnionFind.new(7)

uf.unite(1, 2)
uf.unite(2, 3)
uf.unite(5, 6)

Common::Assert.equal(true,  uf.issame(1, 3))
Common::Assert.equal(false, uf.issame(2, 5))

uf.unite(1, 6)
Common::Assert.equal(true, uf.issame(2, 5))

pp uf.to_string


