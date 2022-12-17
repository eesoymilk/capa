#include <iostream>
#define N 20

const int Initial_x = 6072529;
const long long int SCALED_ATAN_B[N] = {
    450000, 265651, 140362, 71250, 35763, 17899, 8952, 4476, 2238, 1119,
    560, 280, 140, 70, 35, 17, 9, 4, 2, 1};

void Run_Cordic()
{
    long long int x = Initial_x, y = 0, theta, difference;

    std::cin >> theta;
    difference = theta;

    for (int k = 0; k < N; k++) {
        int x_tmp = x;
        if (difference >= 0) {
            x -= y >> k;
            y += x_tmp >> k;
            difference -= SCALED_ATAN_B[k];
        } else {
            x += y >> k;
            y -= x_tmp >> k;
            difference += SCALED_ATAN_B[k];
        }
    }

    std::cout << theta << ' ' << x << ' ' << y << '\n';
}

int main()
{
    int n;
    
    std::cin >> n;
    std::cout << n << '\n';

    while (n--) Run_Cordic();

    return 0;
}