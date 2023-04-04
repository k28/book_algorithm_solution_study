#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# AtCoder Regular Contest 090 D
#

require 'stringio'

# 重みつきUnion-Find
class UnionFindWeight
  attr_reader :par, :siz, :diff_weight

  def initialize(n)
    @par = Array.new(n, -1)
    @siz = Array.new(n, 1)
    @diff_weight = Array.new(n, 0) # 基本的に0を入れる...らしい
  end

  # 根を求める
  def root(x)
    return x if @par[x] == -1

    r = root(@par[x])
    @diff_weight[x] += @diff_weight[@par[x]]
    @par[x] = r
  end

  # 各ノードの重みの取得
  def weight(x)
    root(x)
    return @diff_weight[x]
  end

  # ノード間の差分を取得する
  def diff(x, y)
    return weight(y) - weight(x)
  end

  # xとyが同じグループに属するかどうか (根が一致するかどうか)
  def issame(x, y)
    return root(x) == root(y)
  end

  # xを含むグループとyを含むグループを併合する
  def unite(x, y, w)
    w += weight(x)
    w -= weight(y)
    # x, yをどれぞれ根まで移動する
    x = root(x)
    y = root(y)

    # すでに同じグループの場合は何もしない
    return false if x == y

    # union by size (y側のサイズが小さくなるようにする
    if @siz[x] < @siz[y]
      w = -w
      t = y
      y = x
      x = t
    end

    # yをxの子とする
    @par[y] = x
    @diff_weight[y] = w
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

#__ main __

# 入力 (テスト)
input_str = <<'EOS'
3 3
1 2 1
2 3 1
1 3 2
EOS

# $stdin = StringIO.new(input_str)
$sdtin = STDIN

N, M = gets.chomp.split(' ').map(&:to_i)

ok = true
uf = UnionFindWeight.new(N)
M.times do |i|
  l, r, d = gets.chomp.split(' ').map(&:to_i)
  uf.unite(l - 1, r - 1, d)
  diff = uf.diff(l - 1, r - 1)
  if diff != d
    # diff が異なるパターン
    ok = false
  end
end

print ok ? "Yes" : "No"

