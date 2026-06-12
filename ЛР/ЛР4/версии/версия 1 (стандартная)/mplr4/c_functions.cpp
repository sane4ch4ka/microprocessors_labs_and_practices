#include <cmath>

extern "C" double ComputeFunction(double x)
{
    return log(fabs(cos(x) + sin(x)));
}