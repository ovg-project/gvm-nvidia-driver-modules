# NVIDIA Linux Open GPU Kernel Module Source

This is the source release of the NVIDIA Linux open GPU kernel modules,
version 575.64.05.

# Setup environment for GVM

This is the scripts for setting up gvm nvidia kernel modules conveniently.
The setting up process has no difference from original NVIDIA open GPU kernel modules, but wrapped up with requirement preparing and possible issue solution.
If you want to follow the original setting up process, or want to check out more infomation, see [here](https://github.com/ovg-project/gvm-nvidia-driver-modules/blob/main/README-NVIDIA.md).

Following scripts are testes on `g2-standard-8` and `a2-highgpu-1g` on GCP, with image `ubuntu-accelerator-2404-amd64-with-nvidia-580-v20251021` on `x86/64`.
Need 150GB disk space for installation.

## Setup
```bash
# Change working directory to ./scripts
# All the following scripts need to be executed in ./scripts
cd ./scripts
```

```bash
./download_pkgs.sh

# Required for images comes with NVIDIA driver
sudo bash ./uninstall_nv_driver.sh
# Reboot to complete uninstallation (optional but highly recommended)
sudo reboot

./install_cuda.sh
# Select all default options
./install_nv_driver.sh
```

## Compile

```bash
./compile_modules.sh
```

## Install/uninstall kernel modules

```bash
./deploy_modules.sh  # if first time deploy kernel modules
./redeploy_uvm_module.sh  # uninstall previous kernel modules and re-deploy them
./uninstall_modules.sh  # uninstall previous kernel modules
```

## Running applications

After those steps, the GVM is installed on the system. Please goes to [GVM](https://github.com/ovg-project/GVM) repo to run applications (e.g. diffusion+vLLM).

## What to do when complaining about driver not loaded?

Sometimes you might see the following error:

```bash
$ nvidia-smi
NVIDIA-SMI has failed because it couldn't communicate with the NVIDIA driver. Make sure that the latest NVIDIA driver is installed and running.
$ nvitop
NVML ERROR: Driver Not Loaded
```

This usually happens on restart of the VM. To fix this:

```bash
./deploy_modules.sh
```

