import Foundation

// 部分和問題

func walk(_ i: Int, _ w: Int, _ a: [Int]) -> Bool {
    if i == 0 {
        return (w == 0)
    }

    // a[i - 1]を選ばない場合
    if (walk(i - 1, w, a)) { return true }

    // a[i -  1]を選んだ場合
    if (walk(i - 1, w - a[i - 1], a)) { return true }

    return false
}


let list = [3, 2, 6, 5]
assert(true == walk(list.count, 14, list))
assert(true == walk(list.count, 16, list))
assert(false == walk(list.count, 15, list))

print("ok")

