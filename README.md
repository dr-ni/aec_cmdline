# aec_cmdline
A simple `AEC` (acoustic echo-cancelling) command-line tool based on speexdsp.

## Description

This tool is removing unwanted acoustic loudspeaker-echo from microfone-recordings. It handles the incomming and outgoing audio-streams directly over stdin/stdout - either from raw audio-files or over pipes. The tool is reading a raw stereo `8kHz S16_LE` input-track, holding the microphone-recording on the left and the unwanted echo signal (the loudspeaker reference-playback) on the right. This stereo-track is supplied from a virtual alsa loopback-device.
The processed raw mono `8kHz S16_LE` audio-output is then finally sent to stdout.

## Requirements

- The speexdsp-dev package must be installed with your package manager or by building and installing from source, e.g. from https://github.com/xiph/speexdsp.git.

- The kernel module snd-aloop is required and can be loaded by following command: ```sudo modprobe snd-aloop```

- The alsa-loopback configuration file (initially forked from https://github.com/SaneBow/alsa-aec and modified for 8kHz sampling rate) is installed at /etc/alsa/conf.d/50-aec.conf. It should be changed to fit to your local audio setup.

## Usage

Use with files:

```
aec_cmdline < infile.raw > outfile.raw
```

Input sample:

[infile_s16_le_r8000_c2.raw.zip](https://github.com/dr-ni/aec_cmdline/files/8056481/infile_s16_le_r8000_c2.raw.zip)

Resulting sample:

[outfile_s16_le_r8000_c1 .raw.zip](https://github.com/dr-ni/aec_cmdline/files/8056477/outfile_s16_le_r8000_c1.raw.zip)

Use in combination with bluez-alsa arecord and aplay:

```
arecord -f S16_LE -D bluealsa | aplay -D mono_mloopplay -f S16_LE -r 8000
```

and

```
arecord -D aec_internal -f S16_LE -c 2 -r 8000 | aec_cmdline | aplay -D bluealsa -f S16_LE -c 1 -r 8000
```


## Development

Build:
```sh
make
```

Install:
```sh
sudo make install
```

Uninstall:
```sh
sudo make uninstall
```

----

https://github.com/dr-ni/aec_cmdline

