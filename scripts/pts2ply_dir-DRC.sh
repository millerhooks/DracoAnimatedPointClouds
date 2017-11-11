#!/bin/bash

PTS2PLY=../utils/pts2ply/bin/osx/pts2ply
#SOURCE=../example_sources/AnimatedPointClouds/Private/BrekelKinect_capture_29_10_2016_22_10_18-NO_BACKGROUND_Leica_PTS
SOURCE=/Users/miller/Desktop/DracoAnimatedPointClouds/example_sources/AnimatedPointClouds/Private/LightsSounds06_11_2017_14_31_30_Leica_PTS

ls $SOURCE
#![ -d $SOURCE/PTS ] || mkdir $SOURCE/PTS
#![ -d $SOURCE/PLY ] || mkdir $SOURCE/PLY
#![ -d $SOURCE/DRC ] || mkdir $SOURCE/DRC

if [[ $1 != 'drc' ]]; then

cp $SOURCE/*.pts $SOURCE/PTS

for file in $SOURCE/PTS/*
do
  ex +"%s/$/ 0/g" -cwq $file
  sed '1s/ 0/ /' $file > $file.alpha
  sed 's/ 1.000000/ 0 0 0/' $file > $file.alpha
  cp $file.alpha $file
  rm $file.alpha
done

for file in $SOURCE/PTS/*
do
  echo $($PTS2PLY "$file")
  echo -e "\n"
  mv $SOURCE/PTS/*.ply $SOURCE/PLY
done

fi

for file in $SOURCE/PLY/*
do
  echo $(draco_encoder --skip NORMAL -qp 0 -cl 4 -i "$file" -o "$file".drc.bytes)
  echo -e "\n"
  mv $SOURCE/PLY/*.bytes $SOURCE/DRC
done


