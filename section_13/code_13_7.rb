
#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# 根なし木の操作実装の基本計
# (深さ優先探索)
#

require 'stringio'


# 木上の探索. v:現在探索中の頂点, p: vの親(vが根の時は p = -1)
def dfs(graph, v, p = -1)
  # vから行ける各頂点 next_v について
  graph[v].each do |c|
    next if (c == p) # 探索が親の方向に逆流するのを防ぐ

    # cはvの各小頂点を動く。その時vがcの親
    dfs(graph, c, v)
  end
end


# 入力
input_str = <<'EOS'
12
0 1
1 2
2 3
1 4
4 5
5 6
6 7
6 8
4 9
9 10
9 11
EOS

# __main__
$stdin = StringIO.new(input_str)
#$sdtin = STDIN

N = gets.chomp.to_i

# グラフの定義と読み込み(グラフはListの2次元配列)
G = Array.new(N) { Array.new() }
# 辺の数は必ず(N-1)
(N - 1).times do
  a, b = gets.chomp.split(' ').map(&:to_i)
  # 無向グラフ
  G[a].push(b)
  G[b].push(a)
end

# 探索
dfs(G, 0) # 0を根として探索する

