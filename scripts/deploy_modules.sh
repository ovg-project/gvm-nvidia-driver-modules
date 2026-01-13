#!/bin/bash
# Adapted from vAttention (https://github.com/microsoft/vattention/blob/main/nvidia-vattn-uvm-driver/deploy_nvidia_modules.sh)

# This script must be used on a system reboot to replace propietary nvidia modules
# to custom modules. Just to be safe, this recompiles the modules again --- but this
# step can be skipped.

# Note the order in which modules are removed (rmmod) and inserted (insmod)

SCRIPT_PATH=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
PROJ_DIR=$(dirname "$SCRIPT_DIR")

pushd $PROJ_DIR

# Remove nvidia_* modules
for mod in nvidia_drm nvidia_modeset nvidia_uvm nvidia; do
    if lsmod | grep -q "^$mod"; then
        sudo rmmod $mod
    fi
done

# Load ECC and ECDH modules
sudo modprobe ecc || true
sudo modprobe ecdh_generic || true

# Insert newly compiled modules
sudo insmod kernel-open/nvidia.ko
sudo insmod kernel-open/nvidia-uvm.ko
sudo modprobe video  # needed for nvidia modeset
sudo modprobe drm_ttm_helper # needed for nvidia drm
sudo insmod kernel-open/nvidia-modeset.ko
sudo insmod kernel-open/nvidia-drm.ko

popd
