# Convert to 16/44 FLAC
mkdir outdir

for i in *.flac; do
    ffmpeg -i "$i" -sample_fmt s16 -ar 44100 outdir/"$i";
#   ffmpeg -i "$i" -af aresample=44100:resampler=soxr:precision=33:osf=s16:dither_method=triangular outdir/"$i";
done
