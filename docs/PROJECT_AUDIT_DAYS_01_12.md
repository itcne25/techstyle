# Projektabgleich: Tag 01–12

## Ausgangspunkt und Beleglage

Dieses Team-Repository wurde mit der Tag-13-Musterlösung weitergeführt und an Tag 14 um das AWS-Deployment ergänzt. Der folgende Abgleich bewertet den vorhandenen Projektstand, nicht eine rückwirkend behauptete Teilnahme an früheren Übungen.

Aufgabenquelle ist die bereitgestellte Datei `Tag1-14.txt`, insbesondere die jeweiligen Abschnitte **Projekt**. Die [öffentliche Tagesplanung](https://ch-tbz-wb.gitlab.io/Stud/devops/0_Organisatorisches/Tagesplanungen/Tag01/) war während der Prüfung nicht abrufbar; der Text wurde deshalb direkt aus der bereitgestellten Datei gelesen. Theoriefragen, getrennte Praxis-Repositories und mündliche Gruppenarbeiten werden hier nur erwähnt, wenn sie den Projektstand beeinflussen. Zugangsdaten und die vollständige Kurskopie werden nicht ins Repository aufgenommen.

**Stand:** 28.10.2026. „Vorhanden“ bedeutet, dass die Datei bzw. Konfiguration geprüft wurde. „Betriebsnachweis offen“ bedeutet, dass dafür ein echter Lauf, ein PR, ein Dashboard oder eine Teamhandlung fehlt. Übernommene Mustertexte und bestandene Dateisuchen ersetzen diese Nachweise nicht.

## Übersicht

| Tag | Projekt laut Tagesplanung | Stand im Repository |
| --- | --- | --- |
| 01 | Shop lokal starten, Kickoff und AWS-Zugang verstehen | Startskripte und Projektbeschreibung vorhanden; früherer AWS-/Browsernachweis nicht dokumentiert |
| 02 | GitHub Flow bzw. andere begründete Strategie, Conventional Commits, SemVer und Release | Regeln, Git-Historie und GitHub-Release `v1.0.0` vorhanden; der Release enthält nur die damalige Dokumentationsbasis |
| 03 | Fünf Feature-Requests, MVP-Stufen, Marketingfeedback, Board und User Stories | Konzeptdateien vorhanden; Board-/Issue-Links und versendetes Feedback nicht belegt |
| 04 | CI: erst Linting, dann Tests, Fehler müssen den Lauf abbrechen | `ci.yml`, Unit-/Integrationstests und Test-Fixtures vorhanden |
| 05 | Offene Projektaufträge Tag 01–04 abschliessen; Erweiterungen sind optional | Rückstände hier erfasst; historische Retro und Laufzeitmessungen nicht belegt |
| 06 | Python-Artefakt bauen, temporär speichern, Registry-Entscheidung begründen | Build und Upload vorhanden; Entscheidung in `DAY_6_COMPLETION.md`; Paket ist kein vollständiges Shop-Deploy-Artefakt |
| 07 | SonarQube-Scan mit Coverage und abbrechendem Quality Gate | Scanner-Konfiguration und aktivierbare CI-Anbindung; laufender SonarQube-Server und Scan-Nachweis offen |
| 08 | Einen Praxisstand weiterführen und Basis, Funktion, Fehler, Erweiterung und Prüfung dokumentieren | Früheres Blue-Green/IaC-Beispiel archiviert; aktueller Deploy-Weg ist Tag 13/14, nicht rückwirkend ein Tag-08-Nachweis |
| 09 | Projektaufträge Tag 01–07 aufarbeiten | Diese Bestandsaufnahme erfasst die Lücken; keine historische Retro oder vollständige Abnahme behauptet |
| 10 | Kein separater Projektauftrag | Prometheus/Grafana gehören an diesem Tag zur Praxis; ihre Bereitstellung ist hier nicht nachgewiesen |
| 11 | Node Exporter, dynamische EC2-Erkennung in Prometheus, Systemmetriken in Grafana | Vorbereitung und Runbook unter `monitoring/`; Installation, Targets und Dashboard-Lauf offen |
| 12 | Lokaler AI-Reviewer: Spec, Workflow, Prompt-Evals, ADR und Reflexion | Dateien vorhanden; eigene PR-/Injection-/Eval-Nachweise fehlen in der bisherigen Dokumentation |

## Tag 01 – Projektstart

Der Auftrag verlangt eine laufende lokale TechStyle-Anwendung und Verständnis des Transformationsauftrags. `run_dev.sh` und `run_dev.ps1` richten eine virtuelle Umgebung ein, installieren Abhängigkeiten und initialisieren Beispieldaten. Ohne `DATABASE_URL` nutzt `database.py` eine SQLite-Datei im temporären Verzeichnis; manuelle Windows-Pfadänderungen aus der alten Anleitung sind dadurch nicht mehr nötig. Mit Compose wird seit Tag 13 PostgreSQL verwendet.

TechStyle enthält Katalog, Warenkorb, Checkout und Administration in einem Flask-Monolithen. Die DevOps-Arbeit automatisiert Prüfung, Verpackung und Auslieferung dieser Anwendung. Die README beschreibt den aktuellen Einstieg. Ein AWS-Login ist eine persönliche Lab-Voraussetzung und lässt sich nicht aus einer eingecheckten `.env` beweisen. Die frühere Abnahme von Tag 01 ist nicht dokumentiert.

## Tag 02 – Git, Zusammenarbeit und Releases

[CONTRIBUTING.md](../CONTRIBUTING.md) ist die verbindliche Quelle für GitHub Flow, Branch-Namen, Reviews, Merge-Varianten, Konflikte und Conventional Commits. Die frühere zweite Branching-Beschreibung widersprach dieser Strategie und verweist nun auf dieselbe Quelle. Atomare Commits beschreiben jeweils eine fachliche Änderung.

`.gitignore` schützt unter anderem `.env`, virtuelle Umgebungen und Python-Caches. Der [GitHub-Release `v1.0.0`](https://github.com/itcne25/techstyle/releases/tag/v1.0.0) wurde am 28.08.2026 veröffentlicht und am 28.10.2026 über die GitHub-API geprüft. Der Tag zeigt auf `daf4c88`; `git ls-tree v1.0.0` enthält nur `.gitignore`, `CONTRIBUTING.md`, `README.md` und `docs/`. Das ist ein dokumentierter Projekt-Baseline-Release und keine veröffentlichte Version des heutigen Shops. Der bestehende Tag wird nicht umgeschrieben. Die aus der Musterlösung übernommene Paketversion `1.0.0` ist noch nicht als eigener Shop-Release veröffentlicht.

## Tag 03 – Anforderungen, MVP und Board

Unter [day03/](day03/README.md) liegen Anforderungen zu den fünf Marketing-Requests, die Auswahl von Rabatt-/Gutscheincodes, mehrere MVP-Stufen, User Stories und ein Marketingfeedback. Das trennt Planung von Implementierung: Die Dokumente belegen nicht, dass alle dort geplanten Rabattfunktionen bereits korrekt im Shop umgesetzt sind.

Der Unterordner `05_userstories/` enthält eine zusammengefasste Anleitung für Issues und ein Board. Die GitHub-API lieferte am 28.10.2026 für dieses Repository keine Issues und keine Pull Requests. Eine Projekt-URL ist nicht dokumentiert. Die vorhandene Feedback-Datei ist kein Beleg für einen Versand. Die zwei alten Issue-Skripte mit teils fremden Repository-/Projektreferenzen wurden entfernt; es wurden keine Issues automatisch erstellt.

## Tag 04 – Continuous Integration

[ci.yml](../.github/workflows/ci.yml) startet bei Pushes und Pull Requests auf `main` bzw. `day_*`. Der Linter prüft nach der Kursvorgabe `tests/` und `conftest.py`; der Produktionscode wird damit nicht vollständig gelintet. Der Testjob hängt mit `needs: lint` vom erfolgreichen Lintjob ab. Pytest-Fehler lassen den Job fehlschlagen.

`conftest.py` erstellt für Tests eine isolierte temporäre Datenbank. Neben Unit- und Integrationstests gibt es seit Tag 13 Tests des Datenbankzugriffs und von `/healthz`. Diese aktuelle Lösung erweitert die ursprüngliche Mocking-Vorlage. Ein absichtlich roter historischer Test-Commit ist bisher nicht als Lauf verlinkt; die Fehlerweitergabe ist in der Workflow-Konfiguration erkennbar, ersetzt aber den verlangten Demonstrationslauf nicht.

## Tag 05 – Konsolidierung

Die Tagesplanung führt hier **keinen neuen verpflichtenden Artefakt- oder Monitoringauftrag** ein. Pflicht ist das Aufarbeiten von Tag 01–04. PR-Template, CODEOWNERS, Pipeline-Tuning, `docs/PIPELINE.md` und eine `VERSION`-Datei werden als Kür genannt. Diese Einordnung ist wichtig, weil die übernommenen Classroom-Checks Tag 05 irrtümlich als Artifact Management bezeichneten.

Der [Pipeline-Überblick](PIPELINE.md) beschreibt den aktuellen Zweck der Workflows. Frühere Laufzeitwerte und eine vorher/nachher-Verbesserung werden nicht behauptet. Die offenen Nachweise stehen in der Rückstandsliste unten. Teammitglieder und verbindliche Termine müssen vom Team ergänzt werden; erfundene Namen oder rückdatierte Retrospektiven wären keine belastbare Dokumentation.

## Tag 06 – Artefaktverwaltung

`pyproject.toml` definiert das Python-Paket. Nach erfolgreichen Tests baut `ci.yml` sdist und Wheel und lädt sie als `techstyle-dist` mit 14 Tagen Aufbewahrung hoch. Die gewählte Variante ist das temporäre Workflow-Artefakt. Ein eigener pypiserver ist für den aktuellen Shop nicht erforderlich, weil der betriebliche Deploy-Weg ein vollständiges Containerimage in ECR verwendet.

Die [Artefakt-Dokumentation](DAY_6_COMPLETION.md) erläutert die Entscheidung und ihre Grenzen. Der alte Text behauptete eine Veröffentlichung über einen nicht vorhandenen `publish-pages.yml`-Workflow. Diese Aussage wurde entfernt. Ein Wheel enthält derzeit die Python-Module, aber keine vollständig installierbare Shop-Struktur mit Templates und statischen Dateien; es wird deshalb nicht als Produktions-Deploy verwendet. Das Herunterladen und Inspizieren eines konkreten GitHub-Artefakts bleibt ein eigener Nachweis.

## Tag 07 – SonarQube und Quality Gate

Die Aufgabenquelle verlangt einen echten SonarQube-Scan und einen Abbruch bei rotem Quality Gate. `sonar-project.properties` legt Projekt, Quellen, Tests, Coverage-Datei und `sonar.qualitygate.wait=true` fest. Die frühere Dokumentation behauptete einen Scannerjob, der in `ci.yml` nicht mehr existierte. Die Anbindung wird wieder ausdrücklich konfiguriert; ihre Aktivierung und der tatsächliche Betriebsnachweis sind in [DAY_7_COMPLETION.md](DAY_7_COMPLETION.md) beschrieben.

Ohne erreichbaren SonarQube-Server und passende Secrets darf ein grüner gewöhnlicher CI-Lauf nicht als bestandene SonarQube-Abnahme ausgegeben werden. Die Bereinigung provisioniert keine zusätzliche kostenpflichtige VM und führt keinen erfundenen Scan vor.

## Tag 08 – Deployment weiterführen

Der aktuelle Auftrag erlaubt als Basis einen Compose-, Blue-Green- oder IaC-Praxisstand. Das übernommene Repo enthielt OpenTofu-Dateien, `deploy_docker.sh` sowie frühere Blue-Green-Workflows. Diese verwenden einen eigenen State-Key und andere Ressourcen-/Secret-Namen als Tag 14. Das zusammengehörige Beispiel ist jetzt unter `docs/archive/day08/` erhalten und wird nicht mehr als aktive Deploymentoption in GitHub Actions angeboten.

Für dieses Team ist der tatsächlich weitergeführte Stand die Tag-13-Musterlösung. Die Erweiterung ist Tag 14 mit Tests, ECR-SHA-Image, Compose auf EC2 und Healthchecks. [DEPLOYMENT.md](../DEPLOYMENT.md) beschreibt Ausgangspunkt, Funktion und belegte Läufe. Das ist ein aktueller Implementierungsnachweis; ein früher getestetes ALB-Umschalten, Blue-Green-Rollback oder Terraform-Cleanup wird damit nicht rückwirkend bewiesen.

## Tag 09 – Offene Aufgaben bearbeiten

Tag 09 enthält für das Projekt das Aufarbeiten von Tag 01–07. Die relevanten Lücken sind unten priorisiert. Eine Retro mit echten Massnahmen, Verantwortlichen und Fristen ist eine Teamhandlung. Sie wird hier nicht als durchgeführt markiert. Die alten Checks, die an Tag 09 zwingend Prometheus/Grafana im Projekt verlangten, passen nicht zu dieser Aufgabenquelle.

## Tag 10 – Kein eigener Projektauftrag

Im Projektabschnitt steht ausdrücklich „Nichts“. Prometheus und Grafana auf der SonarQube-VM sind Praxisinhalt und eine Voraussetzung für Tag 11. Fehlende Alerting-Regeln sind deshalb kein eigenständiger Tag-10-Projektmangel. Die Repo-Bereinigung baut keinen erfundenen Alertingauftrag ein.

## Tag 11 – Systemmetriken und dynamische Erkennung

Gefordert sind Node Exporter auf dem Webserver, `ec2_sd_configs` in Prometheus und Systemmetriken in Grafana. Das war im übernommenen Repository nicht vorhanden. Unter [monitoring/](../monitoring/README.md) werden die nötige Konfiguration, ein Dashboard und die Installations-/Prüfschritte vorbereitet.

Der Nachweis bleibt offen, bis ein berechtigter Prometheus-Server die getaggte EC2 über ihr privates Netzwerk entdeckt, den Exporter erfolgreich abfragt und Grafana Daten anzeigt. Ein öffentlich erreichbarer `/healthz`-Endpunkt prüft die Shopbereitschaft und ersetzt keine Hostmetriken. Port 9100 darf nur vom Monitoringserver erreichbar sein.

## Tag 12 – AI-Assisted DevOps

Die Projektartefakte sind vorhanden: [Spec](../specs/ai-review.md), [Review-Workflow](../.github/workflows/ai-review.yml), [Prompt](../prompts/review-system.md), [Evals](../evals/), [Eval-Workflow](../.github/workflows/ai-prompt-eval.yml), [ADR](adr/0001-ai-review-in-der-pipeline.md) und [Reflexion](../AI_INTEGRATION.md). Das Modell läuft im GitHub-Runner; der Bot kommentiert Python-Diffs und entscheidet nicht über einen Merge.

Die Reflexion beschreibt jetzt den vorhandenen Code und benennt die fehlenden eigenen Messungen. Für eine vollständige Team-Abnahme fehlen verlinkte eigene Test-PRs mit AI-Kommentar, ein Injection-Test-PR und ein erfolgreicher Prompt-Eval-Lauf. Die übernommenen Tag-12-Checks verlangten stattdessen Snyk/DAST/SARIF und waren damit sachlich dem falschen Thema zugeordnet; die Projektchecks wurden an die tatsächlich bereitgestellte Aufgabenquelle angepasst.

## Rückstände und nächste überprüfbare Schritte

| Priorität | Aufgabe | Abschlussbeleg |
| --- | --- | --- |
| Hoch | SonarQube-Server bereitstellen bzw. vorhandenen nutzen, Scanner aktivieren | Scan-Link und Quality-Gate-Ergebnis; rotes Gate muss CI fehlschlagen lassen |
| Hoch | Monitoring-Vorbereitung auf realen Servern anwenden | Prometheus-Target `UP`, EC2-Erkennung und Grafana-Systemmetriken |
| Mittel | Eigene Tag-12-Testfälle im PR ausführen | PR mit AI-Kommentar, Injection-Test-PR, grüner Eval-Lauf |
| Mittel | Nächsten Shop-Release sauber versionieren; Tag-03-Board und Issues einrichten | Neuer Shop-Release nach Validierung; eigene Projekt- und Issue-Links |
| Mittel | Artefakt aus einem konkreten CI-Lauf herunterladen und inspizieren | Lauf-Link und überprüfter Paketinhalt |
| Team | Retro und Rückstandsplanung abschliessen | Echte Massnahmen mit Owner und Termin |

Verantwortliche und Termine sind noch nicht vereinbart. Die technischen Dateien werden vorbereitet; die genannten Betriebs- und Teamnachweise bleiben bis zu ihrer Durchführung offen. Der Tag-14-Rollback-Test wurde bewusst ausgelassen und wird nicht als erfolgreich dargestellt.

## Aufräum-Entscheidungen

- Die README beschreibt den aktuellen Teamstand statt das komplette Classroom-Template für Lehrpersonen.
- Der zusätzliche `main.yml`-Workflow, seine vier reinen Echo-Platzhalter und das dazugehörige Erkennungsskript wurden entfernt. Die echten Tests und Builds bleiben in `ci.yml` und `deploy-aws.yml`.
- Die älteren Tag-08-Workflows und das manuelle SCP-Deploy-Beispiel sind unter `docs/archive/` erhalten. Das verhindert eine versehentliche Vermischung mit dem belegten Tag-14-Deploy.
- Anforderungen, MVP-Unterlagen, frühere Infrastruktur, AI-Prompts und Evals bleiben erhalten, weil sie konkrete Kursarbeit abbilden. Sie sind nicht allein wegen ihres Alters überflüssig.
- Doppelte oder falsche Statusaussagen zu Branching, Paketveröffentlichung und SonarQube werden auf einen belegbaren Stand gebracht. Die aktuellen Betriebsanweisungen stehen weiterhin in `DEPLOYMENT.md`.
- Vier redundante Tag-03-Setup-Anleitungen und zwei Issue-Skripte mit fremden Projektreferenzen wurden durch einen kurzen Board-Leitfaden ersetzt. Der versehentlich in den Bot-Prompt eingefügte Tag-13-Seitentext wurde entfernt; die vom Team bereitgestellte Quelldatei bleibt unverändert ausserhalb des Repositories.

## Prüfung der Bereinigung

Am 28.10.2026 wurden lokal folgende Prüfungen tatsächlich ausgeführt:

| Prüfung | Ergebnis |
| --- | --- |
| Pytest gegen isolierte temporäre SQLite-Datenbanken | 7 Tests bestanden, einschliesslich erfolgreichem und fehlgeschlagenem Datenbank-Healthcheck |
| CI-Flake8 auf `tests/` und `conftest.py` | Bestanden; unter Windows mit einem Worker wegen Sandbox-Prozessbeschränkungen |
| Projekt-Strukturchecks Tag 01–12 und Tag 14 mit Git Bash | Bestanden; externe und manuelle Nachweise ausdrücklich ausgenommen |
| Dateimuster-Helfer mit existierenden, fehlenden, alternativen und Glob-Pfaden | Positive und negative Fälle bestanden |
| Bash-Syntax der geänderten Checks und des Evalskripts | Bestanden |
| Aktive GitHub-Workflows mit `actionlint` | Bestanden |
| YAML-/JSON-Parsing und lokale Markdown-Links | Bestanden, keine defekten lokalen Links gefunden |
| Lokaler Python-Build mit `python -m build --no-isolation` | sdist und Wheel erzeugt; Wheel mit acht Einträgen und drei Anwendungsmodulen inspiziert, ohne Templates/Static-Assets |

Die lokale Prüfung verwendete Python 3.12; CI verwendet Python 3.11. Der lokale Docker-Daemon war nicht gestartet, daher wurde bei dieser Bereinigung kein neuer lokaler PostgreSQL-/Containerlauf behauptet. Ein echter SonarQube-Scan, ein Grafana-Import mit Messdaten und Modell-Evals benötigen die oben beschriebenen Dienste. Die vorhandenen `datetime.utcnow()`-Deprecation-Warnungen betreffen unveränderten Anwendungscode.
