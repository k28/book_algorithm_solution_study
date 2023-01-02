import Foundation

// 再帰を使うと計算量が爆発するので
// for分の反復で求める

func fibo(_ n: Int) -> Int {
    if n == 0 { return 0; }
    if n == 1 { return 1; }
    var a = 0
    var b = 1
    for _ in 0..<(n - 1) {
        let tmp = (a + b)
        a = b
        b = tmp
    }

    return b
}

assert(fibo(0) == 0)
assert(fibo(1) == 1)
assert(fibo(2) == 1)
assert(fibo(3) == 2)
assert(fibo(4) == 3)
assert(fibo(5) == 5)

print("25 = \(fibo(25))\n") 
print("50 = \(fibo(50))\n") // 12586269025


