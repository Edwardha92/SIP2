/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * generate_input_vector.h
 *
 * Code generation for function 'generate_input_vector'
 *
 */

#ifndef GENERATE_INPUT_VECTOR_H
#define GENERATE_INPUT_VECTOR_H

/* Include files */
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include "rt_nonfinite.h"
#include "rtwtypes.h"
#include "generate_input_vector_types.h"

/* Function Declarations */
extern void generate_input_vector(const double ecg_chunk[512], double akf_list
  [123783], double input_vector_data[], int input_vector_size[2]);

#endif

/* End of code generation (generate_input_vector.h) */
