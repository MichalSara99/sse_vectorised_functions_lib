#pragma once
#if !defined(_SSE_MATH_X86_EXPORTS)
#define _SSE_MATH_X86_EXPORTS

#include "sse_utilities.h"
#include <typeinfo>

#ifdef SSE_MATH_X86_EXPORTS
#define SSE_MATH_X86_API __declspec(dllexport)
#else
#define SSE_MATH_X86_API __declspec(dllimport)
#endif // SSE_MATH_X86_EXPORTS

/// <summary>
///  ==================================================================================================================================
///  ==================================================== sse_basics
///  ==================================================================
///  ==================================================================================================================================
/// </summary>

namespace sse_basics
{

/// math constants:

// scalar math constant of pi = 3.1415926535897932384626433
const SSE_MATH_X86_API double pi();

/// basic operations:

// packed double-precision floating-point multiplication
SSE_MATH_X86_API bool mul_sse(double const *x_aligned_16, double const *y_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point multiplication
SSE_MATH_X86_API bool mul_sse(float const *x_aligned_16, float const *y_aligned_16, int n4, float *out_aligned_16);
// packed double-precision floating-point division
SSE_MATH_X86_API bool div_sse(double const *x_aligned_16, double const *y_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point division
SSE_MATH_X86_API bool div_sse(float const *x_aligned_16, float const *y_aligned_16, int n4, float *out_aligned_16);
// packed double-precision floating-point addition
SSE_MATH_X86_API bool add_sse(double const *x_aligned_16, double const *y_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point addition
SSE_MATH_X86_API bool add_sse(float const *x_aligned_16, float const *y_aligned_16, int n4, float *out_aligned_16);
// packed double-precision floating-point subtraction
SSE_MATH_X86_API bool sub_sse(double const *x_aligned_16, double const *y_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point subtraction
SSE_MATH_X86_API bool sub_sse(float const *x_aligned_16, float const *y_aligned_16, int n4, float *out_aligned_16);
// packed double-precision floating-point negative value
SSE_MATH_X86_API bool neg_sse(double const *in_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point negative value
SSE_MATH_X86_API bool neg_sse(float const *in_aligned_16, int n4, float *out_aligned_16);
// packed double-precision floating-point inverse(=inverted) value
SSE_MATH_X86_API bool inv_sse(double const *in_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point inverse(=inverted) value
SSE_MATH_X86_API bool inv_sse(float const *in_aligned_16, int n4, float *out_aligned_16);

/// basic functions:

// packed double-precision floating-point absolute value
SSE_MATH_X86_API bool abs_sse(double const *in_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point absolute value
SSE_MATH_X86_API bool abs_sse(float const *in_aligned_16, int n4, float *out_aligned_16);
// packed double-precision floating-point square root value
SSE_MATH_X86_API bool sqrt_sse(double const *in_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point square root value
SSE_MATH_X86_API bool sqrt_sse(float const *in_aligned_16, int n4, float *out_aligned_16);
// packed double-precision floating-point square power value
SSE_MATH_X86_API bool sqrpow_sse(double const *in_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point square power value
SSE_MATH_X86_API bool sqrpow_sse(float const *in_aligned_16, int n4, float *out_aligned_16);
// packed single-precision floating-point minimum values from a pair of allocated aligned memory blocks
SSE_MATH_X86_API bool mins_sse(float const *x_aligned_16, float const *y_aligned_16, int n4, float *out_aligned_16);
// packed double-precision floating-point minimum values from a pair of allocated aligned memory blocks
SSE_MATH_X86_API bool mins_sse(double const *x_aligned_16, double const *y_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point minimum values from a pair of allocated aligned memory blocks
SSE_MATH_X86_API bool maxs_sse(float const *x_aligned_16, float const *y_aligned_16, int n4, float *out_aligned_16);
// packed double-precision floating-point minimum values from a pair of allocated aligned memory blocks
SSE_MATH_X86_API bool maxs_sse(double const *x_aligned_16, double const *y_aligned_16, int n2, double *out_aligned_16);

/// exponential functions:

// packed fast double-precision floating-point exp
SSE_MATH_X86_API bool exp_fast_sse(double const *in_aligned_16, int n2, double *out_aligned_16);
// packed fast single-precision floating-point exp
SSE_MATH_X86_API bool exp_fast_sse(float const *in_aligned_16, int n4, float *out_aligned_16);
// packed double-precision floating-point exp
SSE_MATH_X86_API bool exp_sse(double const *in_aligned_16, int n2, double *out_aligned_16);
// packed fast single-precision floating-point exp
SSE_MATH_X86_API bool exp_sse(float const *in_aligned_16, int n4, float *out_aligned_16);

/// logaritmhmic functions:

// packed fast single-precision floating-point natural log
SSE_MATH_X86_API bool log_sse(float const *in_aligned_16, int n4, float *out_aligned_16);
// packed fast double-precision floating-point natural log
SSE_MATH_X86_API bool log_sse(double const *in_aligned_16, int n2, double *out_aligned_16);

/// trig functions:

// packed double-precision floating-point cosine
SSE_MATH_X86_API bool cos_sse(double const *in_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point cosine
SSE_MATH_X86_API bool cos_sse(float const *in_aligned_16, int n4, float *out_aligned_16);
// packed double-precision floating-point sine
SSE_MATH_X86_API bool sin_sse(double const *in_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point sine
SSE_MATH_X86_API bool sin_sse(float const *in_aligned_16, int n4, float *out_aligned_16);
// packed single-precision floating-point tangens
SSE_MATH_X86_API bool tan_sse(float const *in_aligned_16, int n4, float *out_aligned_16);
// packed single-precision floating-point cotangens
SSE_MATH_X86_API bool cot_sse(float const *in_aligned_16, int n4, float *out_aligned_16);

} // namespace sse_basics

/// <summary>
///  ==================================================================================================================================
///  ============================================= sse_normal_distribution
///  ============================================================
///  ==================================================================================================================================
/// </summary>

namespace sse_normal_distribution
{

// packed single-precision floating-point normal CDF
SSE_MATH_X86_API bool norm_cdf_sse(float const *in_aligned_16, int n4, float *out_aligned_16);
// packed double-precision floating-point normal CDF
SSE_MATH_X86_API bool norm_cdf_sse(double const *in_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point normal PDF
SSE_MATH_X86_API bool norm_pdf_sse(float const *in_aligned_16, int n4, float *out_aligned_16);
// packed double-precision floating-point normal PDF
SSE_MATH_X86_API bool norm_pdf_sse(double const *in_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point inverse normal CDF
SSE_MATH_X86_API bool norm_inv_cdf_sse(float const *in_aligned_16, int n4, float *out_aligned_16);
// packed double-precision floating-point inverse normal CDF
SSE_MATH_X86_API bool norm_inv_cdf_sse(double const *in_aligned_16, int n4, double *out_aligned_16);

} // namespace sse_normal_distribution

/// <summary>
///  ==================================================================================================================================
///  ======================================================== sse_specials
///  ============================================================
///  ==================================================================================================================================
/// </summary>

namespace sse_specials
{

// packed double-precision floating-point error function
SSE_MATH_X86_API bool erf_sse(double const *in_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point error function
SSE_MATH_X86_API bool erf_sse(float const *in_aligned_16, int n4, float *out_aligned_16);
// packed double-precision floating-point complementary error function
SSE_MATH_X86_API bool erfc_sse(double const *in_aligned_16, int n2, double *out_aligned_16);
// packed single-precision floating-point complementary error function
SSE_MATH_X86_API bool erfc_sse(float const *in_aligned_16, int n4, float *out_aligned_16);
} // namespace sse_specials

/// <summary>
///  ==================================================================================================================================
///  ==================================================== sse_utilities
///  ===============================================================
///  ==================================================================================================================================
/// </summary>

namespace sse_utility
{

template <typename Type> Type *aligned_alloc(std::size_t size, std::size_t alignment);

// aligned allocation for single-precision floating point
template <> SSE_MATH_X86_API float *aligned_alloc<float>(std::size_t size, std::size_t alignment);
// aligned allocation for double-precision floating point
template <> SSE_MATH_X86_API double *aligned_alloc<double>(std::size_t size, std::size_t alignment);
// aligned free for single-precision floating point
SSE_MATH_X86_API void aligned_free(float *x);
// aligned free for double-precision floating point
SSE_MATH_X86_API void aligned_free(double *x);

} // namespace sse_utility

#endif ///_SSE_MATH_X86_EXPORTS
