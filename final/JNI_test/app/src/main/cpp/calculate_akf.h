/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * calculate_akf.h
 *
 * Code generation for function 'calculate_akf'
 *
 */

#ifndef CALCULATE_AKF_H
#define CALCULATE_AKF_H

/* Include files */
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include "rt_nonfinite.h"
#include "rtwtypes.h"
#include "generate_input_vector_types.h"

/* Function Declarations */
extern void calculate_akf(const double ecg_chunk[512], double akf[1023]);

#endif

/* End of code generation (calculate_akf.h) */
