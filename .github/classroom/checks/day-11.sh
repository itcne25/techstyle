#!/bin/bash
source .github/classroom/grade.sh

echo "Tag 11 – Node Exporter und dynamische EC2-Erkennung"
echo "Installation, Prometheus-Target UP und Grafana-Messwerte bleiben echte Betriebsnachweise."
check_file_exists "ci-workflow" "Monitoring-Runbook vorhanden" "monitoring/README.md"
check_file_contains "ci-workflow" "Prometheus verwendet EC2 Service Discovery" "monitoring/prometheus.yml" "ec2_sd_configs:"
check_file_contains "ci-workflow" "Node-Exporter-Port konfiguriert" "monitoring/prometheus.yml" "port: 9100"
check_file_contains "ci-workflow" "Discovery beschränkt sich auf getaggte Instanzen" "monitoring/prometheus.yml" "tag:Monitoring"
check_file_exists "ci-workflow" "Grafana-Dashboard vorhanden" "monitoring/grafana/techstyle-host.json"
summary 11
