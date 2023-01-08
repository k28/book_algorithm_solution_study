import Foundation

// ナップサック問題

let weights = [2, 1, 3, 2, 1, 5]
let values = [3, 2, 6, 1, 3, 85]

var dp: [String:Int] = [:]

func makeKey(_ i: Int, _ w: Int) -> String {
    return "\(i)-\(w)"
}

func chMax<T:Comparable>(_ a: T, _ b: T) -> T {
    if a > b {
        return a
    }
    return b
}

let wMax = weights.reduce(0, +)

for i in 0..<(values.count) {
    for w in 0..<(wMax) {
        let i_weight:Int = weights[i]
        let i_value:Int  = values[i]
        // i + 1 を選んだ時
        if w - i_weight >= 0 {
            dp[makeKey(i + 1, w)] = chMax(dp[makeKey(i + 1, w)] ?? 0, (dp[makeKey(i, w - i_weight)] ?? 0) + i_value)
        }

        // i + 1 を選ばない時
        dp[makeKey(i + 1, w)] = chMax(dp[makeKey(i + 1, w)] ?? 0, dp[makeKey(i, w)] ?? 0)
    }
}

//  print("\(dp[makeKey(6, 9)] ?? -1)") // 94

