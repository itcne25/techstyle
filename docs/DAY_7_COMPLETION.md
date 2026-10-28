# Tag 07 – SonarQube-Anbindung

## Implementierung

`sonar-project.properties` beschreibt Quellen, Tests und `coverage.xml`. Mit `sonar.qualitygate.wait=true` wartet der Scanner auf die serverseitige Bewertung und schlägt bei einem roten Quality Gate fehl. Der `sonarqube`-Job in [ci.yml](../.github/workflows/ci.yml) verwendet den Coverage-Bericht des Testjobs. Ein fehlgeschlagener Scan bzw. ein rotes Gate lässt den gesamten CI-Workflow fehlschlagen.

Die Anbindung ist standardmässig deaktiviert, solange kein erreichbarer SonarQube-Server eingerichtet ist. Ein übersprungener Scanner ist **kein** bestandenes Quality Gate. Die Bereinigung legt keine zusätzliche EC2 oder SonarQube-Datenbank an.

## Aktivieren

1. Einen vorhandenen SonarQube-Server aus der Tag-07-Praxis nutzen oder die zugehörige Infrastruktur separat bereitstellen. Adminpasswort ändern und ein Projekt mit Key `techstyle` anlegen.
2. Unter GitHub → Settings → Secrets and variables → Actions die Secrets `SONAR_HOST_URL` und `SONAR_TOKEN` setzen. Die URL muss vom verwendeten Runner erreichbar sein.
3. Die Repository-Variable `SONAR_ENABLED` auf `true` setzen.
4. Eine Änderung per Pull Request prüfen. Unter `sonarqube` muss der Scan tatsächlich laufen, Coverage übernehmen und das Quality Gate abwarten.
5. Den erfolgreichen Scan sowie einen kontrollierten roten Gate-Lauf dokumentieren. Einen blockierenden Befund fachlich beheben, statt das Gate zu umgehen.

Der Paket-Build wartet auf das Quality Gate, wenn der Scanner aktiviert ist. Das Tag-14-Deployment besitzt zusätzlich eine eigene Test-/Containerprüfung; sein Workflow bindet SonarQube derzeit nicht ein. Wer das Quality Gate als verbindliche Produktionsfreigabe nutzt, muss es auch in den Deployment-Freigabepfad aufnehmen.

## Status

Konfiguration und Aktivierungspfad sind vorbereitet. Ein aktuell erreichbarer SonarQube-Server, ein echter Scan und dessen Dashboard-Ergebnis sind noch nicht belegt. Die alte Completion-Datei enthielt fälschlich bereits abgehakte Scanner-Nachweise und feste Testergebnisse aus einem anderen Stand; diese wurden nicht übernommen.

Referenz: [offizielle SonarQube Scan Action](https://github.com/SonarSource/sonarqube-scan-action).
