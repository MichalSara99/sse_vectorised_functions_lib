#pragma once
#if !defined(_BASIC_FUNCTIONS)
#define _BASIC_FUNCTIONS

#include "sse_macros.h"

namespace __packed_sse_
{

// packed double-precision floating-point absolute value
extern "C" bool abs_sse_pd(double const *in_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point absolute value
extern "C" bool abs_sse_ps(float const *in_aligned_16, int n4, float *out_aligned_16);
// packed double-precision floating-point square root
extern "C" bool sqrt_sse_pd(double const *in_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point square root
extern "C" bool sqrt_sse_ps(float const *in_aligned_16, int n4, float *out_aligned_16);
// packed double-precision floating-point square power
extern "C" bool sqrpow_sse_pd(double const *in_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point square power
extern "C" bool sqrpow_sse_ps(float const *in_aligned_16, int n4, float *out_aligned_16);
// packed single-precision floating-point minimum values from a pair of aligned memory blocks
extern "C" bool mins_sse_ps(float const *x_aligned_16, float const *y_aligned_16, int n4, float *out_aligned_16);
// packed double-precision floating-point minimum values from a pair of aligned memory blocks
extern "C" bool mins_sse_pd(double const *x_aligned_16, double const *y_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point maximum values from a pair of aligned memory blocks
extern "C" bool maxs_sse_ps(float const *x_aligned_16, float const *y_aligned_16, int n4, float *out_aligned_16);
// packed double-precision floating-point maximum values from a pair of aligned memory blocks
extern "C" bool maxs_sse_pd(double const *x_aligned_16, double const *y_aligned_16, int n2, double *out_aligned_16);

} // namespace __packed_sse_

namespace sse_math
{

// packed double-precision floating-point absolute value
bool abs_sse_packed(double const *in_aligned_16, int size2, double *out_aligned_16)
{
    return __packed_sse_::abs_sse_pd(in_aligned_16, size2, out_aligned_16);
}
// packed single-precision floating-point absolute value
bool abs_sse_packed(float const *in_aligned_16, int size4, float *out_aligned_16)
{
    return __packed_sse_::abs_sse_ps(in_aligned_16, size4, out_aligned_16);
}

// packed double-precision floating-point square root value
bool sqrt_sse_packed(double const *in_aligned_16, int size2, double *out_aligned_16)
{
    return __packed_sse_::sqrt_sse_pd(in_aligned_16, size2, out_aligned_16);
}
// packed single-precision floating-point square root value
bool sqrt_sse_packed(float const *in_aligned_16, int size4, float *out_aligned_16)
{
    return __packed_sse_::sqrt_sse_ps(in_aligned_16, size4, out_aligned_16);
}

// packed double-precision floating-point square power value
bool sqrpow_sse_packed(double const *in_aligned_16, int size2, double *out_aligned_16)
{
    return __packed_sse_::sqrpow_sse_pd(in_aligned_16, size2, out_aligned_16);
}
// packed single-precision floating-point square power value
bool sqrpow_sse_packed(float const *in_aligned_16, int size4, float *out_aligned_16)
{
    return __packed_sse_::sqrpow_sse_ps(in_aligned_16, size4, out_aligned_16);
}

// packed single-precision floating-point minimum values from a pair of aligned memory blocks
bool mins_sse_packed(float const *x_aligned_16, float const *y_aligned_16, int size4, float *out_aligned_16)
{
    return __packed_sse_::mins_sse_ps(x_aligned_16, y_aligned_16, size4, out_aligned_16);
}

// packed double-precision floating-point minimum values from a pair of aligned memory blocks
bool mins_sse_packed(double const *x_aligned_16, double const *y_aligned_16, int size2, double *out_aligned_16)
{
    return __packed_sse_::mins_sse_pd(x_aligned_16, y_aligned_16, size2, out_aligned_16);
}

// packed single-precision floating-point maximum values from a pair of aligned memory blocks
bool maxs_sse_packed(float const *x_aligned_16, float const *y_aligned_16, int size4, float *out_aligned_16)
{
    return __packed_sse_::maxs_sse_ps(x_aligned_16, y_aligned_16, size4, out_aligned_16);
}

// packed double-precision floating-point maximum values from a pair of aligned memory blocks
bool maxs_sse_packed(double const *x_aligned_16, double const *y_aligned_16, int size2, double *out_aligned_16)
{
    return __packed_sse_::maxs_sse_pd(x_aligned_16, y_aligned_16, size2, out_aligned_16);
}

} // namespace sse_math

#endif ///_BASIC_FUNCTIONS
