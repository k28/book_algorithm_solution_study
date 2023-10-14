#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'stringio'

#
# AtCoder Regular Contest 005 C
# 器物損壊! 高橋くん
# ダイクストラ法でチャレンジ (ヒープを用いる)
# メモリ超過で撃沈
#

# 無限大を表す値 (ここでは十分大きな値を用いることにする)
INF = 2**60

DEBUG = true # デバッグモードならtrue

SENTINEL = "+"
START    = "s"
GOAL     = "g"
WALL     = "#"
WAY      = "."
MAX      = 2

# PriorityQueueを持ってきました
module Common
  class PriorityQueue

    # 2番目の引数に比較のラムダ式を指定します. 指定しない場合は最小値を返すQueueになります
    def initialize(source, comp = lambda { |x, y| x <= y})
      @comp = comp
      @arr = []
      source.each do |e|
        push e
      end
    end

    def size
      @arr.size
    end

    def empty?
      @arr.empty?
    end

    # ヒープの先頭を返す(削除しません)
    def top
      @arr.first
    end

    def push(value)
      @arr << value
      i = @arr.size - 1

      # 親子関係を修復していきます
      while i > 0
        parent = (i - 1) / 2

        # 関係が逆転していなければ終了
        break if @comp.call(@arr[parent], value)
        
        # 親と自分をswapします
        @arr[parent],  @arr[i] = @arr[i], @arr[parent]

        i = parent
      end

      @arr[i] = value
    end

    # ヒープから先頭を取り出す(削除します)
    def pop
      ret_value = top

      # ヒープを再構築します
      tmp_node = @arr.last
      @arr.pop

      i = 0
      while (i * 2 + 1) < size
        # 左右の子ノードの値を比較して小さい(より真の物)方を選びます
        lhs_child = i * 2 + 1 # 左側の子
        rhs_child = i * 2 + 2 # 右側の子
        min_child = lhs_child # 仮定
        if rhs_child < size
          # 右側の子のindexがサイズを超えていない場合(超えてる時はもう無いという事)
          if !@comp.call(@arr[lhs_child], @arr[rhs_child])
            min_child = rhs_child
          end
        end

        # 逆転していなければ終了
        break if @comp.call(tmp_node, @arr[min_child])

        # 自分のノードを子の値にする
        @arr[i] = @arr[min_child]
        i = min_child
      end

      # 選んだノードは最終的にこの位置に決定
      @arr[i] = tmp_node unless empty?
      ret_value
    end

  end

end

def debug_print(s)
  pp s if DEBUG
end

class Edge
  # to: 隣接頂点番号, w: 重み
  attr_reader :to, :w
  
  def initialize(to, w)
    @to = to
    @w = w
  end
end

# 緩和を実施する関数
def chmin(g, a, b)
  if (g[a] > b)
    g[a] = b
    return true
  end

  return false
end

def calc_point(h, w, width)
  (h * width) + w
end

# __main__

# 入力
#input_str = <<'EOS'
#4 5
#s####
#....#
######
##...g
#EOS

input_str = <<'EOS'
10 10
s.........
#########.
#.......#.
#..####.#.
##....#.#.
#####.#.#.
g##.#.#.#.
###.#.#.#.
###.#.#.#.
#.....#...
EOS

#input_str = <<'EOS'
#1 10
#s..####..g
#EOS

# __main__
# $stdin = StringIO.new(input_str)
$sdtin = STDIN

# グラフを読み込む。 周りを番兵で囲んで処理しやすくします
H, W = gets.chomp.split(' ').map(&:to_i)
G = Array.new(H + 2) { Array.new(W + 2, SENTINEL) }

H.times do |h|
  w = 1
  map = gets.chomp.split('').each do |m|
    G[h + 1][w] = m
    w += 1
  end
end

# debug_print(G)

# グラフとして読み込みます
move = [[1, 0], [-1, 0], [0, -1], [0, 1]]
start = 0
goal = 0
GRAPH = Array.new(H*W) { Array.new() }
H.times do |h|
  W.times do |w|
    point = calc_point(h, w, W)
    current_h = h + 1
    current_w = w + 1
    current_value = G[current_h][current_w]
    start = point if current_value == START
    goal = point if current_value == GOAL
    move.each do |m|
      hp = (current_h) + m[0]
      wp = (current_w) + m[1]
      s = G[hp][wp]
      next if s == SENTINEL
      cost = s == WALL ? 1 : 0
      GRAPH[point].push Edge.new(calc_point(hp - 1, wp - 1, W), cost)
    end
  end
end

# ダイクストラ法
n = H * W # 頂点数
dist = Array.new(n, INF)
dist[start] = 0
que = Common::PriorityQueue.new([], lambda {|x, y| x[0] <= y[0]})
que.push([dist[start], start])

while !que.empty?
  # v: 使用済みでない頂点のうち、d[v]が最小の頂点
  # d: vに対するキー値
  v = que.top()[1]
  d = que.top()[0]
  que.pop()

  # d > dist[v]は(d, v)がゴミであることを意味します
  next if d > dist[v]

  # 頂点vを始点とした各辺を緩和
  GRAPH[v].each do |e|
    if (chmin(dist, e.to, dist[v] + e.w))
      # 更新あるならヒープに新しく挿入します
      que.push([dist[e.to], e.to])
    end
  end
end

#debug_print goal
#debug_print dist[goal]

if dist[goal] <= 2
  print "YES\n"
else
  print "NO\n"
end

