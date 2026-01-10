#!/bin/bash
set -e

echo "Pre-downloading model: $MODEL_NAME"

mkdir -p /workspace

python3 - << EOF
from huggingface_hub import snapshot_download

snapshot_download(
    repo_id="${MODEL_NAME}",
    local_dir_use_symlinks=False
)
EOF

echo "Cloning repository..."

if [ ! -d /workspace/exmrvllm/.git ]; then

    git clone https://${GITHUB_TKN}@github.com/axploit/vllm-qwen3.git /workspace/exmrvllm
    cd /workspace/exmrvllm
    
    # Remove token from git remote (security best practice)
    git remote set-url origin https://github.com/axploit/vllm-qwen3.git
else
    cd /workspace/exmrvllm
fi

echo "Startup preparation completed"
# bash start_server.sh
