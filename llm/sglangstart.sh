#!/bin/bash
set -e

rm -rf /workspace/exmrsglang
git clone https://${GITHUB_TKN}@github.com/axploit/sglang-qwen3.git /workspace/exmrsglang
cd /workspace/exmrsglang
git remote set-url origin https://github.com/axploit/sglang-qwen3.git

# Activate conda environment
eval "$(conda shell.bash hook)"
conda activate /venv/main

bash start_server.sh
