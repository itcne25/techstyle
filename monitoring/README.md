# Tag 11 – Node Exporter und EC2-Erkennung

Diese Dateien bereiten den Projektauftrag vor. Es ist noch kein laufendes Monitoring nachgewiesen. Voraussetzung ist ein bestehender Prometheus-/Grafana-Server aus Tag 10 mit Netzwerkzugang zur privaten IP des Webservers.

## Webserver vorbereiten

Auf dem Ubuntu-Webserver installiert `sudo apt-get update && sudo apt-get install -y prometheus-node-exporter` den Exporter aus den Ubuntu-Paketquellen. Mit `sudo systemctl enable --now prometheus-node-exporter` wird sein Dienst aktiviert. `systemctl is-active prometheus-node-exporter` und `curl --fail http://127.0.0.1:9100/metrics` prüfen Dienst und Metrik-Endpunkt. Das ist ein zusätzlicher Hostdienst; der bestehende Shop-Compose-Stack wird dadurch nicht ersetzt.

In der Security Group des Webservers TCP 9100 **nur von der Security Group des Monitoringservers** erlauben. Beide Server benötigen eine passende private Netzwerkverbindung. Keine Freigabe für `0.0.0.0/0`. Die Webserver-EC2 erhält das Tag `Monitoring=techstyle`; die Discovery filtert zusätzlich auf den Instanzzustand `running`.

## Prometheus konfigurieren

Den Job `techstyle-node` aus [prometheus.yml](prometheus.yml) in die vorhandene `scrape_configs`-Liste übernehmen. Die bestehende Konfiguration mit ihren anderen Jobs erhalten. EC2 Service Discovery ermittelt dynamisch private IP-Adressen; beim Austausch einer Instanz muss keine feste IP im Scrape-Job geändert werden.

Prometheus benötigt AWS-Zugriff mit mindestens `ec2:DescribeInstances`. Eine passende EC2-Instanzrolle ist der bevorzugte Weg. Im eingeschränkten Learner Lab kann stattdessen eine für den Prometheus-Dienst verfügbare AWS-Konfiguration notwendig sein; kurzlebige Credentials einschliesslich Session-Token laufen ab. Sie gehören in die geschützte Laufzeitumgebung des Monitoringservers, niemals in diese YAML-Datei oder ins Repository.

Auf dem Monitoringserver vor dem Übernehmen `promtool check config /etc/prometheus/prometheus.yml` ausführen. Nach erfolgreicher Prüfung den bestehenden Dienst mit `sudo systemctl reload prometheus` neu laden, **falls seine Unit einen Reload unterstützt**; andernfalls `sudo systemctl restart prometheus` verwenden. Bei einem Compose-basierten Prometheus die entsprechenden Containerbefehle des bestehenden Setups nutzen.

## Grafana und Abnahme

In Grafana eine Prometheus-Datenquelle mit der internen URL des vorhandenen Servers konfigurieren und [techstyle-host.json](grafana/techstyle-host.json) importieren. Über die Dashboard-Auswahl die richtige Datenquelle wählen. Die Panels zeigen CPU, verfügbaren Arbeitsspeicher, Root-Dateisystem und Exporter-Erreichbarkeit.

Für einen echten Nachweis müssen die folgenden Ergebnisse dokumentiert werden:

1. Vom Monitoringserver liefert `curl --fail http://<PRIVATE-WEBSERVER-IP>:9100/metrics` Hostmetriken.
2. In Prometheus unter Targets steht der automatisch entdeckte Job `techstyle-node` auf `UP`; das Label `instance` enthält die EC2-ID.
3. Die Abfrage `up{job="techstyle-node"}` liefert `1`; `node_memory_MemAvailable_bytes{job="techstyle-node"}` liefert Messwerte.
4. Das importierte Grafana-Dashboard zeigt nach einigen Scrape-Intervallen Systemdaten. CPU-Raten benötigen mehrere Messpunkte.
5. EC2-ID, Zeitpunkt und tatsächliche Prüfresultate im [Projektabgleich](../docs/PROJECT_AUDIT_DAYS_01_12.md) ergänzen. Ausfall und Wiedererkennung können durch einen kontrollierten Exporter-Neustart geprüft werden.

Referenzen: [Prometheus EC2 Service Discovery](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#ec2_sd_config), [Node Exporter](https://prometheus.io/docs/guides/node-exporter/).
