
#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# 再帰を使ってグラフを探索する
# (深さ優先探索)
# トポロジカルソート
# 深さ優先探索の再帰処理を抜ける順番を記憶して、逆順にソートするとトポロジカルソート順になる
#

require 'stringio'

# 深さ優先探索
SEEN = Array.new()
ORDER = Array.new() # トポロジカルソート順を表す

def dfs(graph, v)
  SEEN[v] = true  # vを訪問済みにする

  # vから行ける各頂点 next_v について
  graph[v].each do |next_v|
    next if SEEN[next_v]  # 既に探索済みなら探索しない
    dfs(graph, next_v)    # 再帰的に探索
  end

  # v-outを記録する
  ORDER.push v
end


# 入力
input_str = <<'EOS'
8 13
4 1
4 2
4 6
1 3
1 6
2 5
2 7
6 7
3 0
3 7
7 0
0 5
EOS

# __main__
$stdin = StringIO.new(input_str)
#$sdtin = STDIN

N, M = gets.chomp.split(' ').map(&:to_i)

# グラフの定義と読み込み(グラフはListの2次元配列)
G = Array.new(N) { Array.new() }
(M - 1).times do
  a, b = gets.chomp.split(' ').map(&:to_i)
  G[a].push(b)
end

# 探索
N.times { SEEN.push(false) }  # 初期状態では全頂点が未訪問
(0...N).each do |v|
  next if SEEN[v]  # 既に訪問済みなら探索しない
  dfs(G, v)
end

ORDER.reverse.each do |v|
  print "#{v} -> "
end

