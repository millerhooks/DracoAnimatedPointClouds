#!/bin/bash

PTS2PLY=../utils/pts2ply/bin/osx/pts2ply
SOURCE=../example_sources/AnimatedPointClouds/Private/BrekelKinect_capture_29_10_2016_22_10_18-NO_BACKGROUND_Leica_PTS

ls $SOURCE
for file in $SOURCE/*
do
  echo $($PTS2PLY "$file")
  echo -e "\n"
  mv $SOURCE/*.ply $SOURCE/PLY
done

for file in $SOURCE/PLY/*
do
  echo $(draco_encoder -cl 10 -i "$file")
  echo -e "\n"
  mv $SOURCE/PLY/*.drc $SOURCE/DRC
done


