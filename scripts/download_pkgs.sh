#!/bin/bash

# Install necessary packages
if ! command -v gcc &> /dev/null; then
    sudo apt update
    sudo apt install build-essential -y
fi

wget https://developer.download.nvidia.com/compute/cuda/12.9.1/local_installers/cuda_12.9.1_575.57.08_linux.run &

wget https://us.download.nvidia.com/XFree86/Linux-x86_64/575.57.08/NVIDIA-Linux-x86_64-575.57.08.run &

wait

