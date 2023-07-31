/*
 * aec_cmdline.c
 * A straight forward AEC commandline tool based on speexdsp
 * MIT License Copyright (c) 2022 U. Niethammer
 * compile: gcc aec_cmdline.c -lspeexdsp -o aec_cmdline
 * performs best with newest https://github.com/xiph/speexdsp.git
 */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include "speex/speex_echo.h"
#include "speex/speex_preprocess.h"
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>

#define MONO_FRAME_SIZE 100
#define STEREO_FRAME_SIZE ( MONO_FRAME_SIZE * 2 )
#define FILTER_SIZE 1024
#define SAMPLE_RATE 8000

int main(int argc, char **argv) {

  short input[STEREO_FRAME_SIZE];
  short output[MONO_FRAME_SIZE];
  short rec[MONO_FRAME_SIZE];
  short ref[MONO_FRAME_SIZE];

  size_t input_size = 0;
  size_t output_size = 0;
  int counter = 0;

  SpeexEchoState *st;
  SpeexPreprocessState *den;
  int sampleRate = SAMPLE_RATE;
  
  // init speexdsp
  st = speex_echo_state_init(MONO_FRAME_SIZE, FILTER_SIZE);
  den = speex_preprocess_state_init(MONO_FRAME_SIZE, sampleRate);
  speex_echo_ctl(st, SPEEX_ECHO_SET_SAMPLING_RATE, &sampleRate);
  speex_preprocess_ctl(den, SPEEX_PREPROCESS_SET_ECHO_STATE, st);

  // read the first frame...
  memset(input, 0, sizeof(input));
  memset(output, 0, sizeof(output));
  input_size = fread(input, 1, sizeof(input), stdin);
  do {
    // extract interleaved stereo frame S16_LE to separated mono frames
    // rec and ref
    for (counter = 0; counter < STEREO_FRAME_SIZE; counter += 2) {
      rec[counter / 2] = input[counter];
      ref[counter / 2] = input[counter + 1];
    }

    // do the echo-cancelling
    speex_echo_cancellation(st, rec, ref, output);
    speex_preprocess_run(den, output);

    //output the processed frame
    output_size = fwrite(output, 1, sizeof(output), stdout);
    if (!output_size) {
      fprintf(stderr, "\nError writing frame\n");
      break;
      // no data writable
    }
    if (input_size < sizeof(input)) {
      break;
      // no data readable
    }
    // Put the next frame in buffer
    memset(input, 0, sizeof(input));
    input_size = fread(input, 1, sizeof(input), stdin);
  } while (input_size == sizeof(input));

  // all done
  speex_echo_state_destroy(st);
  speex_preprocess_state_destroy(den);
  return 0;
}
