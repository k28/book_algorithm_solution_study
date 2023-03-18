#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

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

# 入力 (テスト)
input_str = <<'EOS'
7 7
1 3
2 7
3 4
4 5
4 6
5 6
6 7
EOS

#__ main __

$stdin = StringIO.new(input_str)
#$sdtin = STDIN

N, M = gets.chomp.split(' ').map(&:to_i)

A = Array.new()
M.times do |i| 
  # 頂点の添字が1から始まっているので、1減らします
  side = gets.chomp.split(' ').map { |x| x = x.to_i; x -= 1}
  A.push(side)
end

res = 0
(0...M).each do |i|
  uf = UnionFind.new(N)
  
  (0...M).each do |j|
    next if i == j
    s = A[j]
    uf.unite(s[0], s[1])
  end

  # 連結成分の個数を数える (rootの個数をかぞえる. それは頂点とjが同じ物を数えるのと等価)
  num = 0
  (0...N).each do |j|
    num += 1 if uf.root(j) == j
  end

  res += 1 if num > 1
end

print res

