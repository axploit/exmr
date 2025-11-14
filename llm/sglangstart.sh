#!/bin/bash

rm -rf /exmrsglang
git clone https://${GITHUB_TKN}@github.com/axploit/sglang-qwen3.git /exmrsglang
cd /exmrsglang
git remote set-url origin https://github.com/axploit/sglang-qwen3.git
bash /exmrsglang/start_server.sh
