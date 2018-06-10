/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * xcorr.cpp
 *
 * Code generation for function 'xcorr'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "generate_input_vector.h"
#include "xcorr.h"
#include "ifft.h"
#include "fft.h"

/* Function Declarations */
static void crosscorr(const double x[512], const double y[512], double c[1023]);

/* Function Definitions */
static void crosscorr(const double x[512], const double y[512], double c[1023])
{
  creal_T dcv0[1024];
  creal_T dcv1[1024];
  int i;
  creal_T dcv2[1024];
  double c1[1024];
  fft(x, dcv0);
  fft(y, dcv1);
  for (i = 0; i < 1024; i++) {
    dcv2[i].re = dcv0[i].re * dcv1[i].re - dcv0[i].im * -dcv1[i].im;
    dcv2[i].im = dcv0[i].re * -dcv1[i].im + dcv0[i].im * dcv1[i].re;
  }

  ifft(dcv2, dcv0);
  for (i = 0; i < 1024; i++) {
    c1[i] = dcv0[i].re;
  }

  memcpy(&c[0], &c1[513], 511U * sizeof(double));
  memcpy(&c[511], &c1[0], sizeof(double) << 9);
}

void xcorr(const double x[512], const double varargin_1[512], double c[1023])
{
  crosscorr(x, varargin_1, c);
}

/* End of code generation (xcorr.cpp) */
