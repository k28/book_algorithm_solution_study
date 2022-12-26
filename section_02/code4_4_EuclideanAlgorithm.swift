import Foundation

/*
    ユークリッドの互助法(Swiftバージョン)
*/

func GCD(_ m: Int, _ n: Int) -> Int {
    // ベースケース
    if n == 0 {
        return m
    }

    // 再帰呼び出し
    return GCD(n, m % n)
}

func assert(_ expect: (() -> Bool), _ file: String = #file, _ line: Int = #line) {
    if !expect() {
        print("Failed! \(file):\(line)\n")
        exit(-1)
    }
}

assert {GCD(51, 15) == 3}
assert {GCD(12, 18) == 6}
assert {GCD(18, 27) == 9}

print("ok\n")


