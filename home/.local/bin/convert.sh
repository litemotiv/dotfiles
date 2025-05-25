# Convert to 16/44 FLAC
mkdir outdir

shopt -s nullglob

for file in *.{flac,wav,aiff,m4a}; do
	# assumes only one dot in filename
	base_name="${file%.*}"

	# convert
    ffmpeg -i "$file" -sample_fmt s16 -ar 44100 -c:a flac outdir/"${base_name}.flac";
#   ffmpeg -i "$file" -af aresample=44100:resampler=soxr:precision=33:osf=s16:dither_method=triangular outdir/"${base_name}.flac";
done
