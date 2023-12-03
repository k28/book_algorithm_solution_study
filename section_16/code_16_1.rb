#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
#
# フォード・ファルカーソン法 の実装
#
# 最大流量を割り出すアルゴリズム
#

# 辺を表す構造体
# rev: 逆辺(to, from)がG[to]の中で何番目の要素か
# cap: 辺(from, to)の容量
class Edge
  attr_accessor :rev, :from, :to, :cap

  def initialize(r, f, t ,c)
    @rev = r
    @from = f
    @to = t
    @cap = c
  end

end

# グラフを表す構造体
class Graph
  # list: 隣接リスト
  attr_reader :list

  # n:頂点数
  def initialize(n)
    @list = Array.new(n) { Array.new() }
  end

  def size()
    return @list.size()
  end

  # Graphをインスタンスgとしてg[]で値にアクセスできるようにする
  def [](index)
    @list[index]
  end

  # Graphをインスタンスgとして、g[] = で値を代入できるようにする
  def []=(index, value)
    @list[index] = value
  end

  # 辺 e = (u, v)の逆辺(v, u)を取得する (Edgeを返す)
  def redge(e)
    @list[e.to][e.rev]
  end

  # 辺 e = (u, v)に流量fのフローを流す
  # e = (u, v)の流量がfだけ減少する
  # この時、逆辺(v, u)の流量を増やす
  def run_flow(e, f)
    e.cap -= f
    redge(e).cap += f
  end

  # 頂点fromから頂点toへ容量capの辺を張る
  # この時toからfromへも容量0の辺を張っておく
  def addedge(from, to, cap)
    fromrev = @list[from].size()
    torev = @list[to].size()
    @list[from].push Edge.new(torev, from, to, cap)
    @list[to].push Edge.new(fromrev, to, from, 0)
  end
  
end

class FordFulkerson
  attr_reader :seen
  # 無限を表す値...
  INF = 1 << 30
  
  def initialize()
    @seen = Array.new()
  end

  # 残余グラフ上でs-tパスを見つける(深さ優先探索)
  # 戻り値はs-tパス上の容量の最小値(見つからなかったら0)
  # f: sからvへ到達した過程の各辺の容量の最小値
  def fodfs(g, v, t, f)
    # 終端tに到達したらリターン
    return f if v == t

    # 深さ優先探索
    @seen[v] = true
    g[v].each do |e|
      next if @seen[e.to] == true

      # 容量0の辺は実際には存在しない
      next if e.cap == 0

      # s-tパスを探す
      flow = fodfs(g, e.to, t, [f, e.cap].min)

      # s-tパスが見つからなかったら次辺を探す
      next if flow == 0

      # 辺eに容量flowのフローを流す
      g.run_flow(e, flow)

      # s-tパスを見つけたらパス上の最小容量を返す

      return flow
    end

    # パスが見つからなかった
    return 0
  end

  # グラフGのs-t間の最大流量を求める
  # ただしリターン時にGは残余グラフになる
  def solve(g, s, t)
    res = 0

    # 残余グラフにs-tパスがなくなるまで反復
    while true do
      @seen = Array.new(g.size, 0)
      flow = fodfs(g, s, t, INF)

      # s-tパスが見つからなかったら終了
      return res if flow == 0

      res += flow
    end

    # ここには来ないはず
    return 0
  end

end

# __main__

# グラフの入力
# N: 頂点数, M: 辺数

# 入力
input_str = <<'EOS'
6 9
0 1 5
0 3 5
1 3 37
1 2 4
2 4 56
2 5 9
3 2 3
3 4 9
4 5 2
EOS

# __main__
$stdin = StringIO.new(input_str)
#$sdtin = STDIN

# 頂点数と辺数
N, M = gets.chomp.split(' ').map(&:to_i)

g = Graph.new(N)

M.times do |i|
  u, v, c = gets.chomp.split(' ').map(&:to_i)
  # 容量cの辺(u, v)を張る
  g.addedge(u, v, c)
end

# フォードファルカーソン
ff = FordFulkerson.new()
s = 0
t = N - 1

res = ff.solve(g, s, t)
pp res

