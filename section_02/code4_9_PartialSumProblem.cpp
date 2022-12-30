#include <iostream>
#include <string>
#include <vector>

using namespace std;

bool func(int i, int w, const vector<int> &a) {
    // ベースケース
    if (i == 0) {
        return (w == 0);
    }

    // a[i - 1]を選ばない場合
    if (func(i - 1, w, a)) return true;

    // a[i - 1]を選んだ場合
    if (func(i - 1, w - a[i - 1], a)) return true;

    // どちらもfalseの場合
    return false;
}

int
main(int argc, char* argv[]) {

    std::cout << "start \n";

    int W = 14;
    vector<int> a {3, 2, 6, 5};

    cout << func(4, 14, a); // 1 
    cout << func(4, 16, a); // 1 
    cout << func(4, 15, a); // 0
    
    return 0;
}
