#!/bin/bash

if [[ $3 == '-cl' ]]; then
  CL=$4
else
  CL=8
fi

if [[ $2 == '-sk' || true ]]; then
  SK="--skip NORMAL"
fi

if [[ $2 == '-pc' || $4 == '-pc' ]]; then
  PC=-point_cloud
fi

QP="-qp 0"

CMD="draco_encoder $SK $PC $QP -cl $CL -i $1 && draco_decoder -i $1.drc -o out.drc.ply && nano out.drc.ply"
echo -e $CMD

draco_encoder $SK $PC $QP -cl $CL -i $1 && draco_decoder -i $1.drc -o out.drc.ply && nano out.drc.ply
