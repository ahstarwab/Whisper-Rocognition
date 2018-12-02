#!/bin/bash

# Copyright: Junyi Wang
# This script is used to extract wav from the original video
# it is made on modifying extractframe.sh by SUH

# The extracted frames will be stored in wav
rm -r frames*
rm -r audio
mkdir -p audio
data=$1
sort=$2
m=0
for k in ./video/*
do
m=`printf "%02d" $(expr $m + 1)`
name=$sort$m
utt_num=$(find $k/* -maxdepth 0 -type d | wc -l) 

        for i in `seq 1 $utt_num`;
        do
                iter=0
		for file in $k/$i/*.mkv;
		do
                      iter=`printf "%02d" $(expr $iter + 1)`
                      utt=`printf "%02d" $(expr $i)`
		      mkdir -p ./audio/$data/$name
	   	      ffmpeg -hide_banner -i $file -codec pcm_s16le -ac 1 -ar 16000 -vn ./audio/$data/$name/$name'_t'$utt'_s'$iter.wav &
		      mkdir -p ./frames/$name/$name'_t'$utt'_s'$iter
                      ffmpeg -y -hide_banner -loglevel panic -i $file ./frames/$name/$name'_t'$utt'_s'$iter/%d.png
		done
        done

done

