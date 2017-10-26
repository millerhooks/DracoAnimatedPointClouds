#!/bin/bash

PTS2PLY=../utils/pts2ply/bin/osx/pts2ply
SOURCE=../example_sources/AnimatedPointClouds/Brekel/BrekelKinect_capture_29_10_2016_18_09_41_Leica_PTS/*

ls $SOURCE
for file in $SOURCE
do
  echo $($PTS2PLY "$file")
  echo -e "\n"
done
