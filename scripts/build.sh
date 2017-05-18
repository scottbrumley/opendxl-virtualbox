#!/bin/bash



if [ "${1}" == "push" ]; then
    echo "Building and Pushing Container to Docker Hub"
    docker build -t "mcafee:opendxl" .
    docker login
    docker tag mcafee:opendxl sbrumley/opendxl
    docker push sbrumley/opendxl
else
   echo "Building Locally"
   docker build -t "sbrumley:opendxl" .
fi
