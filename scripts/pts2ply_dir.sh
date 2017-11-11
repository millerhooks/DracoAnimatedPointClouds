#!/bin/bash

PTS2PLY=../utils/pts2ply/bin/osx/pts2ply
SOURCE=../example_sources/AnimatedPointClouds/Private/BrekelKinect_capture_29_10_2016_22_10_18-NO_BACKGROUND_Leica_PTS

ls $SOURCE

cp $SOURCE/*.pts $SOURCE/PTS

for file in $SOURCE/PTS/*
do
  ex +"%s/$/ 255/g" -cwq $file
  sed '1s/ 255/ /' $file > $file.255
  sed 's/1.000000/0 0 0/' $file.255 > $file
  rm $file.255
done

for file in $SOURCE/PTS/*
do
  echo $($PTS2PLY "$file")
  echo -e "\n"
  mv $SOURCE/PTS/*.ply $SOURCE/PLY
done

for file in $SOURCE/PLY/*
do
  echo $(draco_encoder -cl 10 -i "$file")
  echo -e "\n"
  mv $SOURCE/PLY/*.drc $SOURCE/DRC
done


