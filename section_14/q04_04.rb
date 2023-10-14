#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'stringio'

#
# AtCoder Regular Contest 005 C
# 器物損壊! 高橋くん
# 0-1 BFSを使うパターン
#

# 無限大を表す値 (ここでは十分大きな値を用いることにする)
INF = 2**60

# 上下左右への動きを表すベクトル
dx = [1, 0, -1, 0]
dy = [0, 1, 0, -1]

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

# __main__
# $stdin = StringIO.new(input_str)
$sdtin = STDIN

H, W = gets.chomp.split(' ').map(&:to_i)
field = Array.new(H)
H.times do |i|
  field[i] = gets.chomp
end

# スタートとゴールのますを割り出す
sx = -1; sy = -1; gx = -1; gy = -1;
H.times do |i|
  W.times do |j|
    (sx = i; sy = j) if field[i][j] == 's'
    (gx = i; gy = j) if field[i][j] == 'g'
  end
end

# 各頂点は配列[x, y]で表す
que = Array.new()

# 初期条件, dist[i][j] はマス(i, j)への最短経路を表す
que.push([sx, sy])
dist = Array.new(H) { Array.new(W, INF) }
dist[sx][sy] = 0

# 0-1 BFS 開始
while !que.empty? do
  x, y = que.shift

  # 隣接頂点を順に見ていく
  4.times do |d|
    nx = x + dx[d]
    ny = y + dy[d]
    
    # 領域外はスキップ
    next if (nx < 0 || nx >= H || ny < 0 || ny >= W)
    # pp "#{nx} : #{ny} #{field[nx][ny]} dist #{dist[nx][ny]} #{dist[x][y]}"

    # コスト0の場合はqueの先頭にpush
    if (field[nx][ny] != '#')
      if (dist[nx][ny] > dist[x][y])
        dist[nx][ny] = dist[x][y]
        que.unshift [nx, ny]
      end
    else
      if (dist[nx][ny] > dist[x][y] + 1)
        dist[nx][ny] = dist[x][y] + 1
        que.push [nx, ny]
      end
    end
  end
end

# 最短経路
if (dist[gx][gy] <= 2)
  print "YES\n"
else
  print "NO\n"
end


