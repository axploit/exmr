#!/bin/bash
set -e

cat > /workspace/comfyui/start_server.sh << 'EOF'
#!/bin/bash

echo "Using Python: $(which python3)"
# Set Python path
export PYTHONPATH="${PYTHONPATH}:$(pwd)"

# Install/upgrade dependencies if needed
# pip install --upgrade pip
# pip install -r requirements.txt

# Check and kill existing processes on port 8000
PORT=8000
echo "Checking for existing processes on port $PORT..."
# echo which python3
echo "Using Python: $(which python3)"

if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null 2>&1; then
    echo "Found process using port $PORT, attempting to stop it..."
    lsof -Pi :$PORT -sTCP:LISTEN -t | xargs kill -9 2>/dev/null || true
    sleep 2
fi

# Also check for any lingering vllm processes
echo "Cleaning up any existing vllm processes..."
pkill -f "main" 2>/dev/null || true
pkill -f "main.py" 2>/dev/null || true
pkill -f "server.py" 2>/dev/null || true
sleep 2

# remove server.log file
rm -f server.log

cd /workspace/comfyui/

echo "Startup Server"

/venv/main/bin/python3 -u main.py --listen 0.0.0.0 --port $PORT >> server.log 2>&1
EOF

chmod +x /workspace/comfyui/start_server.sh

cd /workspace/comfyui/

echo "Startup preparation completed"

bash start_server.sh
