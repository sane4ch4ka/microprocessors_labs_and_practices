#include <iostream>
#include <iomanip>
#include <cmath>
#include <chrono>
#include <limits>
#include <omp.h>

using namespace std;
using namespace chrono;

inline double ComputeFunction(double x)
{
    return log(fabs(cos(x) + sin(x)));
}

int main()
{
    int n;

    cout << "Enter number of points n: ";

    while (!(cin >> n))
    {
        cin.clear();
        cin.ignore(numeric_limits<streamsize>::max(), '\n');

        cout << "Input error. Enter integer number: ";
    }

    if (n <= 0)
    {
        cerr << "Error: n must be greater than 0" << endl;
        return 1;
    }

    double checksum = 0.0;

    auto start = high_resolution_clock::now();

#pragma omp parallel for reduction(+:checksum)
    for (int i = 1; i <= n; i++)
    {
        checksum += ComputeFunction((double)i);
    }

    auto end = high_resolution_clock::now();

    duration<double> elapsed = end - start;

    cout << fixed << setprecision(6);

    cout << "\nFirst 10 results:\n";

    for (int i = 1; i <= min(n, 10); i++)
    {
        cout << "i = "
            << i
            << "\t y = "
            << ComputeFunction((double)i)
            << endl;
    }

    cout << "\nChecksum: "
        << checksum
        << endl;

    cout << "\nExecution time: "
        << elapsed.count()
        << " seconds"
        << endl;

    cout << "\nThreads used: "
        << omp_get_max_threads()
        << endl;

    return 0;
}