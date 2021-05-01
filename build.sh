#!/bin/bash
set -x
if [ ! -d venv ]; then
   deactivate || echo "no venv active"
   conda deactivate || echo "no conda active"
   virtualenv venv --python python3
fi
source ./venv/bin/activate
pip install -r requirements.txt   
# We set a bunch of params to null so we can run collect static
EMAIL_HOST_USER='' EMAIL_HOST_PASSWORD='' STRIPE_SECRET_KEY='' STRIPE_PUBLISHABLE_KEY='' STRIPE_PLAN_MONTHLY_ID='' STRIPE_PLAN_ANNUAL_ID='' STRIPE_WEBHOOK_SIGNING_KEY='' SECRET_KEY='badsecret' EMAIL_HOST="" python manage.py collectstatic
docker buildx build -t holdenk/green-iot-web:latest --push  --platform linux/arm64,linux/amd64 . 
