#!/bin/bash
set -e

python - << 'EOF'
from huggingface_hub import snapshot_download

snapshot_download(
    repo_id="${MODEL_NAME}",
    local_dir_use_symlinks=False
)
EOF

rm -rf /workspace/exmrvllm
git clone https://${GITHUB_TKN}@github.com/axploit/vllm-qwen3.git /workspace/exmrvllm
cd /workspace/exmrvllm
git remote set-url origin https://github.com/axploit/vllm-qwen3.git

# bash start_server.sh
