#!/bin/bash
set -e

: "${MODEL_NAME:?MODEL_NAME is not set}"
: "${GITHUB_TKN:?GITHUB_TKN is not set}"

echo "Pre-downloading model: $MODEL_NAME"

mkdir -p /workspace

(
/venv/main/bin/python3 - << EOF
from huggingface_hub import snapshot_download
embd_model_name = "${EMBED_MODEL_NAME}"
chat_model_name = "${MODEL_NAME}"
if embd_model_name!="":
    snapshot_download(
        repo_id=embd_model_name,
        local_dir_use_symlinks=False
    )
if chat_model_name!="":
    snapshot_download(
        repo_id=chat_model_name,
        local_dir_use_symlinks=False
    )
EOF
) &

DOWNLOAD_PID=$!

echo "Model download started in background (PID=$DOWNLOAD_PID)"

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

# Wait for Model to download before starting server
# wait $DOWNLOAD_PID
# echo "Model download completed"

bash start_server.sh
