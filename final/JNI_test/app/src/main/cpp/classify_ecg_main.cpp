#include <jni.h>
#include <string>

#include "classify.h"
#include "generate_input_vector.h"

static double akf_list[1023 * 104]  {0.0};
static double input_vector[26]      {0.0};
//static double ecg_chunk[512]        {0.0};
static double output_data[1]        {0.0};


extern "C" JNIEXPORT jstring
JNICALL Java_bloodsurfer_jni_1test_MainActivity_stringFromJNI(JNIEnv *env, jobject /* this */)
{
    std::string hello = "Hello world";
    return env->NewStringUTF(hello.c_str());
}


//extern "C"
//JNIEXPORT jboolean JNICALL
//Java_bloodsurfer_jni_1test_Classify_1ecg_classify_1ecg(JNIEnv *env, jobject instance,
//                                                       jdoubleArray ecg_chunk_) {
//    jdouble *ecg_chunk = env->GetDoubleArrayElements(ecg_chunk_, NULL);
//
//    int input_vector_sz[2] = {1, 26};
//    int output_data_sz[2] = {1,1};
//
//    generate_input_vector(ecg_chunk, akf_list, input_vector, input_vector_sz);
//
//    classify(input_vector, output_data, output_data_sz);
//
//    // TODO
//
//    env->ReleaseDoubleArrayElements(ecg_chunk_, ecg_chunk, 0);
//    return output_data[0];
//}


extern "C"
JNIEXPORT jdouble JNICALL
Java_bloodsurfer_jni_1test_Classify_1ecg_classify_1ecg(JNIEnv *env, jobject instance,
                                                       jdoubleArray ecg_chunk_) {
    jdouble *ecg_chunk = env->GetDoubleArrayElements(ecg_chunk_, NULL);

    int input_vector_sz[2] = {1, 26};
    int output_data_sz[2] = {1,1};

    generate_input_vector(ecg_chunk, akf_list, input_vector, input_vector_sz);

    classify(input_vector, output_data, output_data_sz);

    // TODO

    env->ReleaseDoubleArrayElements(ecg_chunk_, ecg_chunk, 0);
    return output_data[0];
}