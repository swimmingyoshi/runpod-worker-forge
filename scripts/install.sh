#!/usr/bin/env bash
echo "Deleting Stable Diffusion WebUI Forge"
rm -rf /workspace/stable-diffusion-webui-forge

echo "Deleting venv"
rm -rf /workspace/venv

echo "Cloning Stable Diffusion WebUI Forge repo to /workspace"
cd /workspace
git clone --depth=1 https://github.com/lllyasviel/stable-diffusion-webui-forge.git

echo "Installing Ubuntu updates"
apt update
apt -y upgrade

echo "Creating and activating venv"
cd stable-diffusion-webui-forge
python3 -m venv /workspace/venv
source /workspace/venv/bin/activate

echo "Installing Torch"
pip3 install --no-cache-dir torch==2.3.1 torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

echo "Installing xformers"
pip3 install --no-cache-dir xformers==0.0.23.post1

echo "Installing Stable Diffusion WebUI Forge"
wget https://raw.githubusercontent.com/ashleykleynhans/runpod-worker-forge/main/install-forge.py
python3 -m install-forge --skip-torch-cuda-test

echo "Cloning the Adetailer Repo"
git clone https://github.com/Bing-su/adetailer.git extensions/Adetailer


echo "Installing RunPod Serverless dependencies"
cd /workspace/stable-diffusion-webui-forge
pip3 install huggingface_hub runpod

echo "Downloading Deliberate v2 model"
cd /workspace/stable-diffusion-webui-forge/models/Stable-diffusion
wget -O deliberate_v2.safetensors https://huggingface.co/XpucT/Deliberate/resolve/main/Deliberate_v2.safetensors

echo "Downloading SDXL base model"
wget https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors

echo "Downloading SDXL Refiner"
wget https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0.safetensors

echo "Downloading SD 1.5 VAE"
cd /workspace/stable-diffusion-webui-forge/models/VAE
wget https://huggingface.co/stabilityai/sd-vae-ft-mse-original/resolve/main/vae-ft-mse-840000-ema-pruned.safetensors

echo "Downloading SDXL VAE"
wget https://huggingface.co/madebyollin/sdxl-vae-fp16-fix/resolve/main/sdxl_vae.safetensors

echo "Downloading SDXL ControlNet models"
mkdir -p /workspace/stable-diffusion-webui-forge/models/ControlNet
cd /workspace/stable-diffusion-webui-forge/models/ControlNet
wget https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/diffusers_xl_canny_full.safetensors

echo "Downloading Upscalers"
mkdir -p /workspace/stable-diffusion-webui-forge/models/ESRGAN
cd /workspace/stable-diffusion-webui-forge/models/ESRGAN
wget https://huggingface.co/ashleykleynhans/upscalers/resolve/main/4x-UltraSharp.pth
wget https://huggingface.co/ashleykleynhans/upscalers/resolve/main/lollypop.pth

echo "Creating log directory"
mkdir -p /workspace/logs

echo "Installing config files"
cd /workspace/stable-diffusion-webui-forge
rm webui-user.sh config.json ui-config.json
wget https://raw.githubusercontent.com/swimmingyoshi/runpod-worker-forge/main/webui-user.sh
wget https://raw.githubusercontent.com/swimmingyoshi/runpod-worker-forge/main/config.json
wget https://raw.githubusercontent.com/swimmingyoshi/runpod-worker-forge/main/ui-config.json

echo "Starting Stable Diffusion WebUI Forge"
deactivate
export HF_HOME="/workspace"
cd /workspace/stable-diffusion-webui-forge
./webui.sh -f
