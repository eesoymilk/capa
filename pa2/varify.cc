#include <fstream>
#include <iostream>

int main()
{
    int i1, i2;
    bool ac = true;
    std::ifstream f1, f2;

    f1.open("main.out");
    f2.open("example.out");

    while (!f1.eof()) {
        f1 >> i1;
        f2 >> i2;
        if (i1 != i2) {
            ac = false;
            break;
        }
    }

    if (ac) std::cout << "PASSED!!!\n";
    else std::cout << "FAILED!!!\n";

    return 0;
}