/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * core.cpp
 *
 * Code generation for function 'core'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "core.h"
#include <stdio.h>
#include <stdlib.h>

/* Function Definitions */
void core(const double input[11], double output[11])
{
  int k;
  int j;
  static const signed char iv0[3] = { 1, 0, 1 };

  memset(&output[0], 0, 11U * sizeof(double));
  for (k = 0; k < 3; k++) {
    for (j = k; j + 1 < 12; j++) {
      output[j] += (double)iv0[k] * input[j - k];
    }
  }
}

void core_initialize()
{
  rt_InitInfAndNaN(8U);
}

void core_terminate()
{
  /* (no terminate code required) */
}

/* End of code generation (core.cpp) */
