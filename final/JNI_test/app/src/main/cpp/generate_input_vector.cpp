/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * generate_input_vector.cpp
 *
 * Code generation for function 'generate_input_vector'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "generate_input_vector.h"
#include "downsample.h"
#include "calculate_akf.h"

/* Function Declarations */
static void process_list(const double akf_list[123783], double values[13],
  double indeces[13]);

/* Function Definitions */
static void process_list(const double akf_list[123783], double values[13],
  double indeces[13])
{
  int i;
  int ix;
  int ixstart;
  double mtmp;
  int itmp;
  double extremum[121];
  int cindx;
  int b_ix;
  int iindx[121];
  boolean_T exitg1;

  /*  PROCESS_LIST Extract and smooth max values and corresponding indeces. */
  /*    [VALUES, INDECES] = PROCESS_LIST(AKF_LIST) */
  /*      filter_coeff = get_filter_coeff(); */
  /*      show_images = false; */
  /* CROP_LIST will extract a window of the first sidelobe peak from the list. */
  /*  */
  /*  The extraction is made in the lower half of the horizontally symmetric */
  /*  akf list. To only extract the desired peak an offset of 39 values from */
  /*  the half downwards is added. */
  for (i = 0; i < 121; i++) {
    ix = i * 105;
    ixstart = i * 105 + 1;
    mtmp = akf_list[(ix % 105 + 1023 * (ix / 105)) + 549];
    itmp = 1;
    cindx = 1;
    if (rtIsNaN(akf_list[(ix % 105 + 1023 * (ix / 105)) + 549])) {
      b_ix = ixstart + 1;
      exitg1 = false;
      while ((!exitg1) && (b_ix <= ix + 105)) {
        cindx++;
        ixstart = b_ix;
        if (!rtIsNaN(akf_list[((b_ix - 1) % 105 + 1023 * ((b_ix - 1) / 105)) +
                     549])) {
          mtmp = akf_list[((b_ix - 1) % 105 + 1023 * ((b_ix - 1) / 105)) + 549];
          itmp = cindx;
          exitg1 = true;
        } else {
          b_ix++;
        }
      }
    }

    if (ixstart < ix + 105) {
      while (ixstart + 1 <= ix + 105) {
        cindx++;
        if (akf_list[(ixstart % 105 + 1023 * (ixstart / 105)) + 549] > mtmp) {
          mtmp = akf_list[(ixstart % 105 + 1023 * (ixstart / 105)) + 549];
          itmp = cindx;
        }

        ixstart++;
      }
    }

    extremum[i] = mtmp;
    iindx[i] = itmp;
  }

  /*      filtered_index = int64(ceil(filtfilt(filter_coeff, [1], idx))); */
  /*      filtered_index(filtered_index == 0) = 1; */
  /*      filtered_index = int64(ceil(filtfilt(1/6 * [1 1 1 1 1 1], [1], idx))); % experimental derived values */
  /*      filtered_max = val(:,filtered_index); */
  downsample(extremum, values);
  for (i = 0; i < 121; i++) {
    extremum[i] = iindx[i];
  }

  downsample(extremum, indeces);

  /*      values = [values filtered_max_val(end)]; */
  /*      indeces = [indeces filtered_idx(end)]; */
  /*      if show_images == true */
  /*  %         hit_rate = 0; */
  /*  %         if obj.data_type == 0 */
  /*  %             hit_rate = obj.n_no / (obj.n_ap + obj.n_no) */
  /*  %         else */
  /*  %             hit_rate = obj.n_ap / (obj.n_ap + obj.n_no) */
  /*  %         end */
  /*  %         figHdl = figure(obj.figure_handle); hold on; */
  /*  %         set(figHdl, 'Name', sprintf('Hitrate: %f', hit_rate)); */
  /*          subplot(2,2,3); imagesc(akf_list); title('AKF list'); %ylim([-hist_half_idx hist_half_idx]); */
  /*          subplot(2,2,4); imagesc(cropped_list); title('AKF window'); hold on; scatter(1:length(max_idx),max_idx, 'gx'); scatter(1:downsample_rate:size(filtered_idx,2), indeces, 'r','filled'); */
  /*   */
  /*          subplot(2,2,2); plot(1:length(max_idx), max_idx); title('Indeces'); set(gca, 'YDir', 'Reverse');  */
  /*          hdl_values = subplot(2,2,1); cla(hdl_values); plot(1:length(max_val), max_val); title('Values');   */
  /*          set(gca, 'YDir', 'Reverse'); */
  /*          drawnow; */
  /*      end */
}

void generate_input_vector(const double ecg_chunk[512], double akf_list[123783],
  double input_vector_data[], int input_vector_size[2])
{
  double dv6[1023];
  int i1;
  static double b_akf_list[123783];
  double values[13];
  double indeces[13];
  double b_values[26];

  /*  GENERATE_INPUT_VECTOR  This function will generate a feature vector based */
  /*  on a ecg vector of 512 elements and the akf_list. */
  /*  */
  /*  This method requires a ecg vector of 512 elements and a (empty) akf_list. */
  /*  The ecg vector will be processed and appended to the akf_list. This list */
  /*  is a ringbuffer containing maximum 121 elements. When the list is full */
  /*  the max values and the corresponding indeces will be extracted from the */
  /*  second maximum of the lower half of the akf_list.  */
  /*  */
  /*  Generate ringbuffer for the list */
  calculate_akf(ecg_chunk, dv6);
  for (i1 = 0; i1 < 120; i1++) {
    memcpy(&b_akf_list[i1 * 1023], &akf_list[i1 * 1023 + 1023], 1023U * sizeof
           (double));
  }

  memcpy(&b_akf_list[122760], &dv6[0], 1023U * sizeof(double));
  for (i1 = 0; i1 < 121; i1++) {
    memcpy(&akf_list[i1 * 1023], &b_akf_list[i1 * 1023], 1023U * sizeof(double));
  }

  process_list(akf_list, values, indeces);
  for (i1 = 0; i1 < 13; i1++) {
    b_values[i1] = values[i1];
    b_values[i1 + 13] = indeces[i1];
  }

  input_vector_size[0] = 26;
  input_vector_size[1] = 1;
  memcpy(&input_vector_data[0], &b_values[0], 26U * sizeof(double));

  /*      warning ('on','all'); */
}

/* End of code generation (generate_input_vector.cpp) */
