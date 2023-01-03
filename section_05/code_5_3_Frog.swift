import Foundation

// Frog問題 (緩和を意識して)

let INF = UInt32.max
let N = 7
let h = [2, 9, 4, 5, 1, 6, 10]
var list: [UInt32] = Array(repeating: INF, count: N)

func chmin<T:Comparable>(_ list: inout [T], _ i: Int, _ b: T) {
    if list[i] > b {
        list[i] = b
    }
}

// 初期状態
list[0] = 0

for i in 1..<N {
    // 隣からの移動
    chmin(&list, i, UInt32(abs(h[i - 1] - h[i])) + list[i - 1])

    // 1つ前からの移動
    if i - 2 >= 0 {
        chmin(&list, i, UInt32(abs(h[i - 2] - h[i])) + list[i - 2])
    }
}

print(list.last ?? "?")

