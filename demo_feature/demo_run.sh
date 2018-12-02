#!/bin/bash
stage=$1
# --stage <stage> # 0:no skpping(default)
#                 # 1:skip extractng wav and frame
#                 # 2:skip extracting  mouse landmark
#                 # 3:skip extracting feature and pca
#                 # 4:skip duplicating features and converting to ark
#                 # 5:skip converting to binary and zip
START=$(date +%s)
data=$2
sort=$3
CNN=$4
if [ $# -ge 1 ]; then
    echo "This process is for extracting '$data' data set"
fi

if [ ! -d "video" ]; then
    echo "There should be a video directory."
    exit 1
fi

if [ $stage -le 0 ]; then
    echo "--------------------------------------------------------------------------------"
    date
    if [ $data == demo ]; then
       data=test
       ./demo_wav_frame_spl.sh $data $sort
       data=demo
    else
       ./demo_wav_frame.sh $data $sort 
    fi
    echo "Stage 1 : Extracting wav and frames completes."
fi

if [ $stage -le 1 ]; then
    echo "--------------------------------------------------------------------------------"
    date
    if [ $data == demo ]; then
        data=test
        ./demo_mouth_spl.sh $sort
    else
        ./demo_mouth.sh $sort
    fi

    echo "Stage 2 : Extracting mouse region completes."
fi

if [ $stage -le 2 ]; then
    echo "--------------------------------------------------------------------------------"
    date
    ./demo_feature.sh $data $sort $CNN || exit 1
    echo "Stage 3 : Extracting features and pca completes."
fi

if [ $stage -le 3 ]; then
    echo "--------------------------------------------------------------------------------"
    date
    ./demo_ark.sh $data $sort || exit 1
    echo "Stage 4 : matching video frames and converting to ark files completes."
fi

if [ $stage -le 4 ]; then
    echo "--------------------------------------------------------------------------------"
    date
    ./demo_final.sh $1 || exit 1
    echo "Stage 5 : converting binary ark files and zipping completes."
fi
echo "--------------------------------------------------------------------------------"
date

END=$(date +%s)
echo $(($END-$START))
echo "All pre-process stage completes."
