#!/bin/bash
set -e

echo "Pull latest code..."
git pull origin main

echo "Rebuild only app services..."

docker-compose up -d --build backend frontend nginx

echo "Cleaning old images..."
docker image prune -f

echo "Deploy complete!"