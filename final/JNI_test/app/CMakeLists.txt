cmake_minimum_required(VERSION 3.4.1)


set(INCS
    src/main/cpp/calculate_akf.h
    src/main/cpp/downsample.h
    src/main/cpp/fft.h
    src/main/cpp/generate_input_vector.h
    src/main/cpp/generate_input_vector_data.h
    src/main/cpp/generate_input_vector_initialize.h
    src/main/cpp/generate_input_vector_terminate.h
    src/main/cpp/generate_input_vector_types.h
    src/main/cpp/ifft.h
    src/main/cpp/xcorr.h
    src/main/cpp/classify.h
    src/main/cpp/classify_initialize.h
    src/main/cpp/classify_terminate.h
    src/main/cpp/classify_types.h
	src/main/cpp/rt_nonfinite.h
	src/main/cpp/rtGetInf.h
	src/main/cpp/rtGetNaN.h
	src/main/cpp/rtwtypes.h
)

set(SRCS
    src/main/cpp/calculate_akf.cpp
    src/main/cpp/downsample.cpp
    src/main/cpp/fft.cpp
    src/main/cpp/generate_input_vector.cpp
    src/main/cpp/generate_input_vector_data.cpp
    src/main/cpp/generate_input_vector_initialize.cpp
    src/main/cpp/generate_input_vector_terminate.cpp
    src/main/cpp/ifft.cpp
    src/main/cpp/xcorr.cpp
    src/main/cpp/classify.cpp
    src/main/cpp/classify_initialize.cpp
    src/main/cpp/classify_terminate.cpp
    src/main/cpp/rt_nonfinite.cpp
    src/main/cpp/rtGetInf.cpp
    src/main/cpp/rtGetNaN.cpp
)





add_library(classify_ecg SHARED src/main/cpp/classify_ecg_main.cpp ${SRCS} ${INCS})


find_library(log-lib log )


target_link_libraries(classify_ecg ${log-lib} )