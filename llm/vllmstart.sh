#!/bin/bash
set -e

rm -rf /workspace/exmrvllm
git clone https://${GITHUB_TKN}@github.com/axploit/vllm-qwen3.git /workspace/exmrvllm
cd /workspace/exmrvllm
git remote set-url origin https://github.com/axploit/vllm-qwen3.git

bash start_server.sh
