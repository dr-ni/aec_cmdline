# aec_cmdline
A straight forward AEC proove of concept based on speexdsp

This tool can be easily used with files:

`aec_cmdline < infile.raw > outfile.raw`

Input sample:

[infile_s16_le_r16000_c2.raw.zip](https://github.com/Arkq/bluez-alsa/files/8037121/infile_s16_le_r16000_c2.raw.zip)

Resulting sample:

[outfile_s16_le_r16000_c1.raw.zip](https://github.com/Arkq/bluez-alsa/files/8037159/outfile_s16_le_r16000_c1.raw.zip)

(sorry for some clipping samples)

or in combination with bluez-alsa arecord and aplay:

`arecord -f S16_LE -D bluealsa | aplay -D mloopplay -f S16_LE -r 16000`

and

`arecord -D aec_internal -f S16_LE -c 2 -r 16000 | aec_cmdline | aplay -D bluealsa`

The tool is reading a stereo track, holding the local recording on the left and the parasitic reference signal (here bluealsa remote) on the right. The required input stereo track is being supplied from a loopback device as described in:

https://github.com/SaneBow/alsa-aec.git
