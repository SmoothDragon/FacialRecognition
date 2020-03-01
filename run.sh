#!/bin/bash

BASE_DIR=($PWD)
echo $BASE_DIR

cd face_recognition_demo
# python ./face_recognition_demo.py \
python ./checkin.py \
  -m_fd $BASE_DIR/models/face-detection-retail-0004.xml \
  -m_lm $BASE_DIR/models/landmarks-regression-retail-0009.xml \
  -m_reid $BASE_DIR/models/face-reidentification-retail-0095.xml \
  -l /opt/intel/openvino/deployment_tools/inference_engine/lib/intel64/libcpu_extension_sse4.so \
  --verbose \
  -fg $BASE_DIR/face_gallery

