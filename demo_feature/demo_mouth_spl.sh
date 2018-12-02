#!/bin/bash

# Copyright: Junyi Wang
# This script is used to extract wav from the original video
# it is made on modifying extractframe.sh by SUH

if [ -d ./mouth ]; then
        rm -r ./mouth
fi
# The extracted frames will be stored in wav
mkdir -p ./mouth
        for spk in ./frames/*
        do
                      outdir=$(echo $spk | sed -e "s/frames/mouth/")
                      file0=$(echo $spk | sed -e "s/frames/frames_split0/")
                      file1=$(echo $spk | sed -e "s/frames/frames_split1/")
                      file2=$(echo $spk | sed -e "s/frames/frames_split2/")
                      file3=$(echo $spk | sed -e "s/frames/frames_split3/")
                      file4=$(echo $spk | sed -e "s/frames/frames_split4/")
                      file5=$(echo $spk | sed -e "s/frames/frames_split5/")
                      file6=$(echo $spk | sed -e "s/frames/frames_split6/")
                      file7=$(echo $spk | sed -e "s/frames/frames_split7/")
                      mkdir -p $outdir/wv01_t01_s01
                      python mouthExtract_multi.py -p ./shape_predictor_68_face_landmarks.dat \
                           -i1 $file0 -i2 $file1 -i3 $file2 -i4 $file3 -i5 $file4 -i6 $file5 -i7 $file6 -i8 $file7 -o $outdir
                      echo "Finish Extrating mouth for $spk"
	done
