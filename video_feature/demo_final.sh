	# last step, convert the feature file to kaldi binary format
	for f in `find ./final/* -type f`;
	do
		finalPath=$(echo $f | cut -d "/" -f 1-4 | sed -e "s/final/finalbin/")
		echo $finalPath
		mkdir -p $finalPath
		finalFileName=$(echo $f | sed -e "s/final/finalbin/")
		echo $finalFileName
		# use kalditool to convert things into binary
		/home/Uihyeop/kaldi/src/featbin/copy-feats ark,t:$f ark:$finalFileName
	done
	tar -zcvf videoFeatures.tar.gz ./finalbin/*
        tar -zcvf audiowav.tar.gz ./audio/*
echo "Final Stage Completes! Video Features are extracted successfully. It can be found at './videoFeatures.tar.gz'"
