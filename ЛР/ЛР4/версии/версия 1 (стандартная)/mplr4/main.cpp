#include <iostream>
#include <iomanip>
#include <limits>

using namespace std;

extern "C" double CalculateY(int x);

int main()
{
    int n;

    cout << "Enter number of points n: ";

    while (!(cin >> n))
    {
        cin.clear();
        cin.ignore((numeric_limits<streamsize>::max)(), '\n');

        cout << "Input error. Enter integer number: ";
    }

    if (n <= 0)
    {
        cerr << "Error: n must be greater than 0" << endl;
        return 1;
    }

    cout << fixed << setprecision(6);

    cout << "\nResults:\n";
    cout << "--------------------------\n";

    for (int i = 1; i <= n; i++)
    {
        double y = CalculateY(i);

        cout << "i = "
            << i
            << "\t y = "
            << y
            << endl;
    }

    return 0;
}