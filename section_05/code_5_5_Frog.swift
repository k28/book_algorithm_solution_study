import Foundation

// Frog問題 (配る遷移形式)

let INF = Int.max
let h = [2, 9, 4, 5, 1, 6, 10]

// 足場0から足場iまでの最小コストを返す
func walk(_ list: [Int], _ i: Int) -> Int {
    // ベースケース
    if i == 0 {
        return 0
    }

    // 1つ前からの移動コスト
    let c1 = walk(list, i - 1) + abs(list[i] - list[i - 1])

    // 2つ前からの移動コスト
    var c2 = INF
    if i - 2 >= 0 {
        c2 = walk(list, i - 2) + abs(list[i] - list[i - 2])
    }

    return min(c1, c2)
}

// print(h)
print(walk(h, h.count - 1))

