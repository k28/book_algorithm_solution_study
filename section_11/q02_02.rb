#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# AtCoder Beginner Contest 120 D
# 愚直に解くと時間が間に合わないので改善パターン
# i-1の状態からの差分考慮する
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

def conbi_2(n)
  return (n * (n - 1)) / 2
end

# 入力 (テスト)
input_str = <<'EOS'
4 5
1 2
3 4
1 3
2 3
1 4
EOS

#__ main __

#$stdin = StringIO.new(input_str)
$sdtin = STDIN

# 入力の取り込み N:島の数, M:橋の数
N, M = gets.chomp.split(' ').map(&:to_i)
A = Array.new()
M.times do |i| 
  # 頂点の添字が1から始まっているので、1減らします
  side = gets.chomp.split(' ').map { |x| x = x.to_i; x -= 1}
  A.push(side)
end

# 橋を壊していくのではなく、追加していく形にしたいので、Aを反転させます
A.reverse!

total_pair = conbi_2(N)
fubin = total_pair
result = []

# 橋を追加しながらUnionFindを構築していきます
uf = UnionFind.new(N)
A.each do |side|
  result.push(fubin)

  a = side[0]
  b = side[1]

  next if uf.issame(a, b)

  # a, bの島が異なるので、繋ぐことで不憫さが解消する
  # 解消する不憫さは aの島のサイズ x bの島のサイズ
  sa = uf.size(a)
  sb = uf.size(b)

  fubin -= (sa * sb)

  uf.unite(a, b)
end

result.reverse.each {|i| pp i}

