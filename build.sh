#!/bin/bash
set -x
if [ ! -d venv ]; then
   deactivate || echo "no venv active"
   conda deactivate || echo "no conda active"
   virtualenv venv --python python3
fi
source ./venv/bin/activate
pip install -r requirements.txt   
python manage.py collectstatic
docker buildx build -t holdenk/green-iot-web:latest --push  --platform linux/arm64,linux/amd64 . 
