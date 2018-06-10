/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * downsample.cpp
 *
 * Code generation for function 'downsample'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "generate_input_vector.h"
#include "downsample.h"

/* Function Definitions */
void downsample(const double x[121], double y[13])
{
  int ix;
  int iy;
  int k;
  ix = 0;
  iy = 0;
  for (k = 0; k < 13; k++) {
    y[iy] = x[ix];
    ix += 10;
    iy++;
  }
}

/* End of code generation (downsample.cpp) */
