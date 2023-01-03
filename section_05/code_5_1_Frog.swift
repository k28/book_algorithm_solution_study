import Foundation

// Frog問題

let INF = UInt32.max
let N = 7
let h = [2, 9, 4, 5, 1, 6, 10]
var list: [UInt32] = Array(repeating: INF, count: N)

// 初期状態
list[0] = 0

for i in 1..<N {
    // 隣からの移動
    let c1 = UInt32(abs(h[i - 1] - h[i])) + list[i - 1]

    // 1つ前からの移動
    var c2 = INF
    if i - 2 >= 0 {
        c2 = UInt32(abs(h[i - 2] - h[i])) + list[i - 2]
    }

    list[i] = min(c1, c2)
}

print(list.last ?? "?")

