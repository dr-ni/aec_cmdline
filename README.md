# aec_cmdline
A simple aec (acoustic echo-cancelling) commandline tool based on speexdsp.

## Description

This tool handles incomming and outgoing audio and can be easily used with files or pipes. The tool is reading a
stereo track, holding the local recording on the left and the parasitic echo-reference signal on the right.
The required raw stereo input-track is being supplied from a loopback device as described in https://github.com/SaneBow/alsa-aec.git.

## Requirements

The speexdsp-dev package must be installed with your package manager or by building and installing from source, e.g. from https://github.com/xiph/speexdsp.git.
The kernel module snd-aloop is required and can be loaded by following command:

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

