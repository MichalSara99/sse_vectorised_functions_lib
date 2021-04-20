#include "headers/sse_math_x86_lib.h"
#include "headers/math_constants.h"
#include "headers/pch.h"
#include "headers/sse_math_x86.h"
#include "headers/sse_utilities.h"

using namespace sse_math;

/// ================================================ MATH CONSTANTS
/// ==========================================================

// scalar math constant of pi = 3.1415926535897932384626433
const double sse_basics::pi()
{
    return sse_constants::pi;
}

/// ================================================ BASIC OPERATIONS
/// ==========================================================

// packed double-precision floating-point multiplication
bool sse_basics::mul_sse(double const *x_aligned_16, double const *y_aligned_16, int n2, double *out_aligned_16)
{
    return sse_math::mul_sse_packed(x_aligned_16, y_aligned_16, n2, out_aligned_16);
}
// packed single-precision floating-point multiplication
bool sse_basics::mul_sse(float const *x_aligned_16, float const *y_aligned_16, int n4, float *out_aligned_16)
{
    return sse_math::mul_sse_packed(x_aligned_16, y_aligned_16, n4, out_aligned_16);
}
// packed double-precision floating-point division
bool sse_basics::div_sse(double const *x_aligned_16, double const *y_aligned_16, int n2, double *out_aligned_16)
{
    return sse_math::div_sse_packed(x_aligned_16, y_aligned_16, n2, out_aligned_16);
}
// packed single-precision floating-point division
bool sse_basics::div_sse(float const *x_aligned_16, float const *y_aligned_16, int n4, float *out_aligned_16)
{
    return sse_math::div_sse_packed(x_aligned_16, y_aligned_16, n4, out_aligned_16);
}
// packed double-precision floating-point addition
bool sse_basics::add_sse(double const *x_aligned_16, double const *y_aligned_16, int n2, double *out_aligned_16)
{
    return sse_math::add_sse_packed(x_aligned_16, y_aligned_16, n2, out_aligned_16);
}
// packed single-precision floating-point addition
bool sse_basics::add_sse(float const *x_aligned_16, float const *y_aligned_16, int n4, float *out_aligned_16)
{
    return sse_math::add_sse_packed(x_aligned_16, y_aligned_16, n4, out_aligned_16);
}
// packed double-precision floating-point subtraction
bool sse_basics::sub_sse(double const *x_aligned_16, double const *y_aligned_16, int n2, double *out_aligned_16)
{
    return sse_math::sub_sse_packed(x_aligned_16, y_aligned_16, n2, out_aligned_16);
}
// packed single-precision floating-point subtraction
bool sse_basics::sub_sse(float const *x_aligned_16, float const *y_aligned_16, int n4, float *out_aligned_16)
{
    return sse_math::sub_sse_packed(x_aligned_16, y_aligned_16, n4, out_aligned_16);
}
// packed double-precision floating-point negative value
bool sse_basics::neg_sse(double const *in_aligned_16, int n2, double *out_aligned_16)
{
    return sse_math::neg_sse_packed(in_aligned_16, n2, out_aligned_16);
}
// packed single-precision floating-point negative value
bool sse_basics::neg_sse(float const *in_aligned_16, int n4, float *out_aligned_16)
{
    return sse_math::neg_sse_packed(in_aligned_16, n4, out_aligned_16);
}
// packed double-precision floating-point inverse(=inverted) value
bool sse_basics::inv_sse(double const *in_aligned_16, int n2, double *out_aligned_16)
{
    return sse_math::inv_sse_packed(in_aligned_16, n2, out_aligned_16);
}
// packed single-precision floating-point inverse(=inverted) value
bool sse_basics::inv_sse(float const *in_aligned_16, int n4, float *out_aligned_16)
{
    return sse_math::inv_sse_packed(in_aligned_16, n4, out_aligned_16);
}

/// ================================================ BASIC FUNCTIONS
/// ==========================================================

// packed double-precision floating-point absolute value
bool sse_basics::abs_sse(double const *in_aligned_16, int n2, double *out_aligned_16)
{
    return sse_math::abs_sse_packed(in_aligned_16, n2, out_aligned_16);
}
// packed single-precision floating-point absolute value
bool sse_basics::abs_sse(float const *in_aligned_16, int n4, float *out_aligned_16)
{
    return sse_math::abs_sse_packed(in_aligned_16, n4, out_aligned_16);
}
// packed double-precision floating-point square root value
bool sse_basics::sqrt_sse(double const *in_aligned_16, int n2, double *out_aligned_16)
{
    return sse_math::sqrt_sse_packed(in_aligned_16, n2, out_aligned_16);
}
// packed single-precision floating-point square root value
bool sse_basics::sqrt_sse(float const *in_aligned_16, int n4, float *out_aligned_16)
{
    return sse_math::sqrt_sse_packed(in_aligned_16, n4, out_aligned_16);
}
// packed double-precision floating-point square power value
bool sse_basics::sqrpow_sse(double const *in_aligned_16, int n2, double *out_aligned_16)
{
    return sse_math::sqrpow_sse_packed(in_aligned_16, n2, out_aligned_16);
}
// packed single-precision floating-point square power value
bool sse_basics::sqrpow_sse(float const *in_aligned_16, int n4, float *out_aligned_16)
{
    return sse_math::sqrpow_sse_packed(in_aligned_16, n4, out_aligned_16);
}

// packed single-precision floating-point minimum values from a pair of allocated aligned memory blocks
bool sse_basics::mins_sse(float const *x_aligned_16, float const *y_aligned_16, int n4, float *out_aligned_16)
{
    return sse_math::mins_sse_packed(x_aligned_16, y_aligned_16, n4, out_aligned_16);
}
// packed double-precision floating-point minimum values from a pair of allocated aligned memory blocks
bool sse_basics::mins_sse(double const *x_aligned_16, double const *y_aligned_16, int n2, double *out_aligned_16)
{
    return sse_math::mins_sse_packed(x_aligned_16, y_aligned_16, n2, out_aligned_16);
}
// packed single-precision floating-point minimum values from a pair of allocated aligned memory blocks
bool sse_basics::maxs_sse(float const *x_aligned_16, float const *y_aligned_16, int n4, float *out_aligned_16)
{
    return sse_math::maxs_sse_packed(x_aligned_16, y_aligned_16, n4, out_aligned_16);
}
// packed double-precision floating-point minimum values from a pair of allocated aligned memory blocks
bool sse_basics::maxs_sse(double const *x_aligned_16, double const *y_aligned_16, int n2, double *out_aligned_16)
{
    return sse_math::maxs_sse_packed(x_aligned_16, y_aligned_16, n2, out_aligned_16);
}

/// ================================================ EXPONENTIAL FUNCTIONS
/// ==========================================================

// packed fast double-precision floating-point exp
bool sse_basics::exp_fast_sse(double const *in_aligned_16, int n2, double *out_aligned_16)
{
    return sse_math::exp_fast_sse_packed(in_aligned_16, n2, out_aligned_16);
}
// packed fast single-precision floating-point exp
bool sse_basics::exp_fast_sse(float const *in_aligned_16, int n4, float *out_aligned_16)
{
    return sse_math::exp_fast_sse_packed(in_aligned_16, n4, out_aligned_16);
}
// packed double-precision floating-point exp
bool sse_basics::exp_sse(double const *in_aligned_16, int n2, double *out_aligned_16)
{
    return sse_math::exp_sse_packed(in_aligned_16, n2, out_aligned_16);
}
// packed fast single-precision floating-point exp
bool sse_basics::exp_sse(float const *in_aligned_16, int n4, float *out_aligned_16)
{
    return sse_math::exp_sse_packed(in_aligned_16, n4, out_aligned_16);
}

/// ================================================ LOGARITHMIC FUNCTIONS
/// ==========================================================

// packed fast single-precision floating-point natural log
bool sse_basics::log_sse(float const *in_aligned_16, int n4, float *out_aligned_16)
{
    return sse_math::log_sse_packed(in_aligned_16, n4, out_aligned_16);
}
// packed fast double-precision floating-point natural log
bool sse_basics::log_sse(double const *in_aligned_16, int n2, double *out_aligned_16)
{
    return sse_math::log_sse_packed(in_aligned_16, n2, out_aligned_16);
}

/// ================================================ NORMAL DISTRIBUTION FUNCTIONS
/// ==========================================================

// packed single-precision floating-point normal CDF
bool sse_normal_distribution::norm_cdf_sse(float const *in_aligned_16, int n4, float *out_aligned_16)
{
    return sse_math::norm_cdf_sse_packed(in_aligned_16, n4, out_aligned_16);
}
// packed double-precision floating-point normal CDF
bool sse_normal_distribution::norm_cdf_sse(double const *in_aligned_16, int n2, double *out_aligned_16)
{
    return sse_math::norm_cdf_sse_packed(in_aligned_16, n2, out_aligned_16);
}
// packed single-precision floating-point normal PDF
bool sse_normal_distribution::norm_pdf_sse(float const *in_aligned_16, int n4, float *out_aligned_16)
{
    return sse_math::norm_pdf_sse_packed(in_aligned_16, n4, out_aligned_16);
}
// packed double-precision floating-point normal PDF
bool sse_normal_distribution::norm_pdf_sse(double const *in_aligned_16, int n2, double *out_aligned_16)
{
    return sse_math::norm_pdf_sse_packed(in_aligned_16, n2, out_aligned_16);
}
// packed single-precision floating-point inverse normal CDF
bool sse_normal_distribution::norm_inv_cdf_sse(float const *in_aligned_16, int n4, float *out_aligned_16)
{
    return sse_math::norm_inv_cdf_sse_packed(in_aligned_16, n4, out_aligned_16);
}

/// ================================================ SPECIAL FUNCTIONS
/// ==========================================================

// packed double-precision floating-point error function
bool sse_specials::erf_sse(double const *in_aligned_16, int n2, double *out_aligned_16)
{
    return sse_math::erf_sse_packed(in_aligned_16, n2, out_aligned_16);
}
// packed single-precision floating-point error function
bool sse_specials::erf_sse(float const *in_aligned_16, int n4, float *out_aligned_16)
{
    return sse_math::erf_sse_packed(in_aligned_16, n4, out_aligned_16);
}
// packed double-precision floating-point complementary error function
bool sse_specials::erfc_sse(double const *in_aligned_16, int n2, double *out_aligned_16)
{
    return sse_math::erfc_sse_packed(in_aligned_16, n2, out_aligned_16);
}
// packed single-precision floating-point complementary error function
bool sse_specials::erfc_sse(float const *in_aligned_16, int n4, float *out_aligned_16)
{
    return sse_math::erfc_sse_packed(in_aligned_16, n4, out_aligned_16);
}

/// ================================================ TRIG FUNCTIONS
/// ==========================================================

// packed double-precision floating-point cosine
bool sse_basics::cos_sse(double const *in_aligned_16, int n2, double *out_aligned_16)
{
    return sse_math::cos_sse_packed(in_aligned_16, n2, out_aligned_16);
}
// packed single-precision floating-point cosine
bool sse_basics::cos_sse(float const *in_aligned_16, int n4, float *out_aligned_16)
{
    return sse_math::cos_sse_packed(in_aligned_16, n4, out_aligned_16);
}
// packed double-precision floating-point sine
bool sse_basics::sin_sse(double const *in_aligned_16, int n2, double *out_aligned_16)
{
    return sse_math::sin_sse_packed(in_aligned_16, n2, out_aligned_16);
}
// packed single-precision floating-point sine
bool sse_basics::sin_sse(float const *in_aligned_16, int n4, float *out_aligned_16)
{
    return sse_math::sin_sse_packed(in_aligned_16, n4, out_aligned_16);
}
// packed single-precision floating-point tangens
bool sse_basics::tan_sse(float const *in_aligned_16, int n4, float *out_aligned_16)
{
    return sse_math::tan_sse_packed(in_aligned_16, n4, out_aligned_16);
}
// packed single-precision floating-point cotangens
bool sse_basics::cot_sse(float const *in_aligned_16, int n4, float *out_aligned_16)
{
    return sse_math::cot_sse_packed(in_aligned_16, n4, out_aligned_16);
}

/// ================================================ UTILITY FUNCTIONS
/// ==========================================================

// aligned allocation for single-precision floating point
template <> SSE_MATH_X86_API float *sse_utility::aligned_alloc<float>(std::size_t size, std::size_t alignment)
{
    return sse_utilities::aligned_alloc<float>(size, alignment);
}
// aligned allocation for double-precision floating point
template <> SSE_MATH_X86_API double *sse_utility::aligned_alloc<double>(std::size_t size, std::size_t alignment)
{
    return sse_utilities::aligned_alloc<double>(size, alignment);
}

// allocation free for single-precision floating point
void sse_utility::aligned_free(float *x)
{
    return sse_utilities::aligned_free(x);
}
// allocation free for double-precision floating point
void sse_utility::aligned_free(double *x)
{
    return sse_utilities::aligned_free(x);
}
