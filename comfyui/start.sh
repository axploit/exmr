#!/bin/bash
set -e

cd /workspace/comfyui/

echo "Startup preparation completed"

# Wait for Model to download before starting server
# wait $DOWNLOAD_PID
# echo "Model download completed"

python3 main.py --listen 0.0.0.0 --port 8000 >> server.log 2>&1
