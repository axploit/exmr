#!/bin/bash
set -e

rm -rf /workspace
git clone https://${GITHUB_TKN}@github.com/axploit/sglang-qwen3.git /workspace
cd /workspace
git remote set-url origin https://github.com/axploit/sglang-qwen3.git

# Activate conda environment
eval "$(conda shell.bash hook)"
conda activate /venv/main

bash start_server.sh
