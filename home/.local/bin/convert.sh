# Convert to 16/44 FLAC
mkdir outdir

for i in *.flac; do
  ffmpeg -i "$i" -sample_fmt s16 -ar 44100 outdir/"$i";
done
