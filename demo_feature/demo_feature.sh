# This will store the order of input
CNN=$3
sort=$2
data=$1

if [ -d ./features ]; then
         rm -r ./features
fi

mkdir -p ./features
for file in mouth/*;
        do
                name=$(echo $file | cut -d "/" -f 2)
                mkdir -p ./features/$name
		find `pwd`/mouth/$name -type f -exec echo {} \; | sort -V > ./features/$name/$name.list
		# run the script and output to $name.vec
		echo "Begin extracting features for $name."
                if [ $CNN == googlenet ]; then
                       python featureExtract_googlenet.py -i ./features/$name/$name.list -o ./features/$name/$name.vec
                elif [ $CNN == YOLO ]; then
                       python featureExtract_YOLO.py -i ./features/$name/$name.list -o ./features/$name/$name.vec 
                elif [ $CNN == resnet ]; then
                       python featureExtract_ResNet.py -i ./features/$name/$name.list -o ./features/$name/$name.vec 
                elif [ $CNN == demo ]; then
                       python featureExtract_multi.py -i ./features/$name/$name.list -o ./features/$name/$name.vec 
                elif [ $CNN == resnet_18 ]; then
                       python featureExtract_ResNet_18.py -i ./features/$name/$name.list -o ./features/$name/$name.vec 
                elif [ $CNN == alexnet ]; then
                       python featureExtract_alexnet.py -i ./features/$name/$name.list -o ./features/$name/$name.vec 
                elif [ $CNN == vgg ]; then
                       python featureExtract_vgg.py -i ./features/$name/$name.list -o ./features/$name/$name.vec 
                elif [ $CNN == mobile ]; then
                       python featureExtract_mobile.py -i ./features/$name/$name.list -o ./features/$name/$name.vec 
                elif [ $CNN == dense ]; then
                       python featureExtract_dense.py -i ./features/$name/$name.list -o ./features/$name/$name.vec 
                elif [ $CNN == mobile_v2 ]; then
                       python featureExtract_mobile_v2.py -i ./features/$name/$name.list -o ./features/$name/$name.vec 
                fi
                echo "Finish extracting features for $name."
        done
date
if [ ! -f ./features/entire.vec ] || [ ! -f ./features/entire.list ]
then
        touch ./features/entire.vec
        touch ./features/entire.list
        spk_num=`printf "%02d" $(find ./features/* -maxdepth 0 -type d | wc -l)`
        for i in `seq 1 $spk_num`
        do
               spk=`printf "%02d" $i`
               cat ./features/$sort$spk/$sort$spk.list >> ./features/entire.list
               cat ./features/$sort$spk/$sort$spk.vec >> ./features/entire.vec
        done
       
        sed -i ./features/entire.vec -e "s/ /, /g"
        echo "Finish concatenation."
fi

if [ ! -f ./features/pca_entire.vec ]
then
        echo "Begin feature selection"
        if [ $data == train ]; then
             rm pca_info.pickle
        fi
        python ./pca.py ./features/entire.vec ./features/pca_entire.vec $data
fi

if [ ! -f ./features/output.list ]
then
        cp ./features/entire.list ./features/output.list
        sed -i ./features/output.list -e "s/mouth/features/"
        sed -i ./features/output.list -e "s/\.png//"
        echo "Output direction generation completes"
fi

echo "Start writing features to corresponding files"
./writeFeatures.sh ./features/output.list ./features/pca_entire.vec
echo "Finish writing features to corresponding files"

