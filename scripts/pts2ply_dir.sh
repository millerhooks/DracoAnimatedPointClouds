#!/bin/bash

PTS2PLY=../utils/pts2ply/bin/osx/pts2ply_nocolor
SOURCE=../example_sources/AnimatedPointClouds/Brekel/BrekelKinect_capture_29_10_2016_18_09_41_Leica_PTS/

ls $SOURCE
for file in $SOURCE*
do
  echo $($PTS2PLY "$file")
  echo -e "\n"
  mv $SOURCE*.ply $SOURCE../converted/PLY
done

for file in $SOURCE../converted/PLY/*
do
  echo $(draco_encoder -i "$file")
  echo -e "\n"
  mv $SOURCE../converted/PLY/*.drc $SOURCE../converted/DRC
done


