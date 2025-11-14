#!/bin/bash
set -e

rm -rf /workspace/exmrsglang
git clone https://${GITHUB_TKN}@github.com/axploit/sglang-qwen3.git /workspace/exmrsglang
cd /workspace/exmrsglang
git remote set-url origin https://github.com/axploit/sglang-qwen3.git

bash start_server.sh
