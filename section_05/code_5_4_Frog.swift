import Foundation

// Frog問題 (配る遷移形式)

let INF = UInt32.max
let N = 7
let h = [2, 9, 4, 5, 1, 6, 10]
var list: [UInt32] = Array(repeating: INF, count: N)

// listのi番目とbを比較して、小さい方でi番目を更新します
func chooseMinimum<T:Comparable>(_ list: inout [T], _ i: Int, _ b: T) {
    if list[i] > b {
        list[i] = b
    }
}

// 初期状態
list[0] = 0

for i in 0..<N {
    // 隣の値を更新
    if i + 1 < N {
        let p = i + 1
        chooseMinimum(&list, p, list[i] + UInt32(abs(h[i] - h[p])))
    }

    // 隣の隣を更新
    if i + 2 < N {
        let p = i + 2
        chooseMinimum(&list, p, list[i] + UInt32(abs(h[i] - h[p])))
    }
}

// print(list)
print(list.last ?? "?")

