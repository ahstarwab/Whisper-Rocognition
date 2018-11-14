#!/bin/bash

# Copyright: Junyi Wang
# This script is used to extract wav from the original video
# it is made on modifying extractframe.sh by SUH

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
                      file0=$(echo $spk | sed -e "s/frames/frames_split0/")
                      file1=$(echo $spk | sed -e "s/frames/frames_split1/")
                      file2=$(echo $spk | sed -e "s/frames/frames_split2/")
                      file3=$(echo $spk | sed -e "s/frames/frames_split3/")
                      file4=$(echo $spk | sed -e "s/frames/frames_split4/")
                      file5=$(echo $spk | sed -e "s/frames/frames_split5/")
                      file6=$(echo $spk | sed -e "s/frames/frames_split6/")
                      file7=$(echo $spk | sed -e "s/frames/frames_split7/")
                      python mouthExtract.py -p ./shape_predictor_68_face_landmarks.dat -i $file0 -o $outdir &
                      python mouthExtract.py -p ./shape_predictor_68_face_landmarks.dat -i $file1 -o $outdir &
                      python mouthExtract.py -p ./shape_predictor_68_face_landmarks.dat -i $file2 -o $outdir &
                      python mouthExtract.py -p ./shape_predictor_68_face_landmarks.dat -i $file3 -o $outdir &
                      python mouthExtract.py -p ./shape_predictor_68_face_landmarks.dat -i $file4 -o $outdir &
                      python mouthExtract.py -p ./shape_predictor_68_face_landmarks.dat -i $file5 -o $outdir &
                      python mouthExtract.py -p ./shape_predictor_68_face_landmarks.dat -i $file6 -o $outdir &
                      python mouthExtract.py -p ./shape_predictor_68_face_landmarks.dat -i $file7 -o $outdir
                      wait
                      echo "Finish Extrating mouth for $spk"
	done
