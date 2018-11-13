# This will store the order of input
sort=$1
mkdir -p ./features
if [ ! -f ./features ]
then
for split in `seq 0 7`; do
        for file in mouth_split$split/*;
        do
                name=$(echo $file | cut -d "/" -f 2)
		rm -rf ./features
                mkdir -p ./features/$name
		find `pwd`/mouth/$name -type f -exec echo {} \; | sort -V > ./features/$name/$name.list
		# run the script and output to $name.vec
		echo "Begin extracting features for $name."
		python featureExtract.py -i ./features/$name/$name.list -o ./features/$name/$name.vec &
		echo "Finish extracting features for $name."
        done
done
fi

wait

if [ ! -f ./features/entire.vec ] || [ ! -f ./features/entire.list ]
then
        touch ./features/entire.vec
        touch ./features/entire.list
        spk_num=`printf "%02d" $(find ./features -type d | wc -l)`
        for i in `seq 1 $spk_num`
        do
               spk=`printf "%02d" $i`
               cat ./features/$sort$spk/$sort$spk.list >> ./features/entire.list
               cat ./features/$sort$spk/$sort$spk.vec >> ./features/entire.vec
        done
       
        cp ./features/entire.vec ./features/entire.vec.copy
        sed -i ./features/entire.vec -e "s/ /, /g"
        echo "Finish concatenation."
fi

if [ ! -f ./features/pca_entire.vec ]
then
        echo "Begin feature selection"
        python ./pca.py ./features/entire.vec ./features/pca_entire.vec
fi

if [ ! -f ./features/output.list ]
then
        cp ./features/entire.list ./features/output.list
        sed -i ./features/output.list -e "s/mouth/features/"
        sed -i ./features/output.list -e "s/\.png//"
        echo "Output direction generation completes"
fi

echo "Start writing features to corresponding files"
chmod 777 ./writeFeatures.sh
./writeFeatures.sh ./features/output.list ./features/pca_entire.vec
echo "Finish writing features to corresponding files"

