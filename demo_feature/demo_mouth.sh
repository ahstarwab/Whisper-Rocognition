#!/bin/bash

# Copyright: Junyi Wang
# This script is used to extract wav from the original video
# it is made on modifying extractframe.sh by SUH
sort=$1

rm -r mouth

if [ ! -f ./shape_predictor_68_face_landmarks.dat ]
then
	wget http://dlib.net/files/shape_predictor_68_face_landmarks.dat.bz2
	bzip2 -d shape_predictor_68_face_landmarks.dat.bz2
	rm shape_predictor_68_face_landmarks.dat.bz2
	echo "Pretrained face recognizer downloaded complete"
else
	echo "Pretrained face recognizer exists. Start to extract mouth"
fi

# The extracted frames will be stored in wav
mkdir -p ./mouth
        for spk in ./frames/*
        do
                      outdir=$(echo $spk | sed -e "s/frames/mouth/")
                      python mouthExtract.py -p ./shape_predictor_68_face_landmarks.dat -i $spk -o $outdir & 
                      echo "Start Extracting mouth for $spk"
	done

wait
echo "Finish Extracting all mouth images"
