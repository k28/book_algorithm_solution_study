import Foundation

// メモ化で再起のフィボナッチ数列計算を高速化

var memo: [Int: Int] = [:]

func fibo(_ n: Int) -> Int {
    if let v = memo[n] {
        return v
    }
    if n == 0 { return 0 }
    if n == 1 { return 1 }

    memo[n] = fibo(n - 1) + fibo(n - 2)
    return memo[n]!
}

assert(fibo(0) == 0)
assert(fibo(1) == 1)
assert(fibo(2) == 1)
assert(fibo(3) == 2)
assert(fibo(4) == 3)
assert(fibo(5) == 5)

print("25 = \(fibo(25))") 
print("50 = \(fibo(50))") // 12586269025

