# aec_cmdline
A simple AEC (acoustic echo-cancelling) command-line tool based on speexdsp.

## Description

This tool is removing unwanted acoustic loudspeaker-echo from microfone-recordings. It handles the incomming and outgoing audio-streams directly over stdin/stdout - either from raw audio-files or over pipes. The tool is reading a raw stereo input-track, holding the microphone-recording on the left and the unwanted echo signal (the loudspeaker reference-playback) on the right. This stereo-track can be supplied from a virtual alsa loopback-device, as described in https://github.com/SaneBow/alsa-aec.git.
The prosessed audio-output is then finally sent to stdout.

## Requirements

- The speexdsp-dev package must be installed with your package manager or by building and installing from source, e.g. from https://github.com/xiph/speexdsp.git.

- The kernel module snd-aloop is required and can be loaded by following command:

```
sudo modprobe snd-aloop
```


## Usage

This tool can be used with files:

```
aec_cmdline < infile.raw > outfile.raw
```

Input sample:

[infile_s16_le_r16000_c2.raw.zip](https://github.com/Arkq/bluez-alsa/files/8037121/infile_s16_le_r16000_c2.raw.zip)

Resulting sample:

[outfile_s16_le_r16000_c1.raw.zip](https://github.com/Arkq/bluez-alsa/files/8037159/outfile_s16_le_r16000_c1.raw.zip)

(sorry for some clipping samples)

or in combination with bluez-alsa arecord and aplay:

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

## FILES

The alsa-loopback configuration file 50-aec.conf is stored in /etc/alsa/conf.d/

----

https://github.com/dr-ni/aec_cmdline

