#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# AtCoder Beginner Contest 049 D
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

#__ main __

# 入力 (テスト)
input_str = <<'EOS'
4 3 2
1 2
2 3
3 4
2 3
3 4
EOS

$stdin = StringIO.new(input_str)
# $sdtin = STDIN

N, K, L = gets.chomp.split(' ').map(&:to_i)

road = UnionFind.new(N)
train = UnionFind.new(N)

# 道で連結している都市のUnion-Findを作成します
K.times do |i|
  w = gets.chomp.split(' ').map(&:to_i)
  road.unite(w[0] - 1, w[1] - 1)
end

# 鉄道で連結している都市のUnion-Findを作成します
L.times do |i|
  l = gets.chomp.split(' ').map(&:to_i)
  train.unite(l[0] - 1, l[1] - 1)
end

# 各都市を分類します
nums = Hash.new(0)
N.times do |i|
  root_road = road.root(i)
  root_train = train.root(i)
  key = [root_road, root_train]
  nums[[root_road, root_train]] += 1
end

# 結果を出力します
N.times do |i|
  root_road = road.root(i)
  root_train = train.root(i)
  key = [root_road, root_train]

  # pp "=> #{i} [#{root_road},#{root_train}]"
  print "#{nums[key]} "
end

print "\n"

