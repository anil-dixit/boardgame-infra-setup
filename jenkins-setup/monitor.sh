#!/bin/bash

# Update package list
sudo apt-get update -y

# Install Prometheus
echo "Installing Prometheus..."
sudo apt-get install -y prometheus prometheus-blackbox-exporter

# Install Grafana
echo "Installing Grafana..."
sudo apt-get install -y software-properties-common
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
sudo wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
sudo apt-get update -y
sudo apt-get install -y grafana

# Start and enable services
echo "Starting and enabling Prometheus and Grafana services..."
sudo systemctl enable --now prometheus
sudo systemctl enable --now grafana-server

echo "Installation complete!"


