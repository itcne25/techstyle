# Tag 06 – Artefaktverwaltung

## Umsetzung

`pyproject.toml` definiert `techstyle` mit Version `1.0.0` und den Modulen `app`, `database` und `seed_data`. Der `build`-Job in [ci.yml](../.github/workflows/ci.yml) läuft nach erfolgreichen Tests. `python -m build` erzeugt sdist und Wheel; `actions/upload-artifact` speichert sie unter `techstyle-dist` für 14 Tage. Das Coverage-XML ist ein separates Prüfarbeitsartefakt.

Ein Build-Artefakt ist ein gespeichertes Ergebnis aus einem bestimmten Quellstand. Ein Actions-Artefakt dient hier zur Inspektion und kurzfristigen Übergabe. Die Aufbewahrungsfrist macht es ungeeignet als dauerhaftes Paketarchiv. Identische Bytes bei wiederholten Builds werden durch die aktuelle Build-Konfiguration nicht garantiert.

## Entscheidung für TechStyle

Für den Python-Build reicht **Option 1: temporäres Workflow-Artefakt**. Der Shop wird als vollständiges Dockerimage nach ECR ausgeliefert; Image-Tags entsprechen dem Commit-SHA. Es gibt aktuell keinen belegten Verbraucher, der das Python-Paket dauerhaft aus einer eigenen Registry installieren muss. Der zusätzliche Betrieb eines pypiserver würde deshalb ohne konkreten Nutzen Authentifizierung, TLS, Speicherung, Backups und Pflege verlangen.

Ein pypiserver wäre sinnvoll, wenn mehrere Projekte versionierte Python-Pakete per `pip install` wiederverwenden. Er bietet dauerhafte Versionen und eine bekannte Installationsschnittstelle, verlangt aber einen eigenen sicheren Betrieb. Ein verwalteter Feed wie Azure DevOps Artifacts nimmt einen Teil dieses Betriebs ab; dafür entstehen Anbieterbindung, Berechtigungs- und gegebenenfalls Kostenfragen. Diese Varianten sind Zieloptionen und hier nicht bereitgestellt.

Vor einer Registry-Veröffentlichung müssten Tests, geeignete Sicherheitsprüfungen und eine überprüfte Version erfolgreich sein. Paketversion und Release-Tag müssten zusammenpassen; eine bereits veröffentlichte Version dürfte nicht mit anderem Inhalt überschrieben werden. Die derzeitige Paketversion wird bewusst in `pyproject.toml` gepflegt, während das Cloudimage durch den SHA identifiziert wird.

## Grenzen und Nachweise

Das Wheel enthält derzeit Python-Module, aber keine vollständig installierbare Shop-Struktur mit `templates/` und `static/`. `run-techstyle` ist deshalb kein eigenständiger Ersatz für den Container-Deploy. Das Containerimage enthält die Anwendung einschliesslich ihrer Assets.

Der frühere Text behauptete einen GitHub-Pages-Paketindex über `publish-pages.yml`. Dieser Workflow existiert in diesem Repository nicht; eine solche Veröffentlichung ist nicht nachgewiesen. Ebenso werden keine lokalen Build-Ergebnisse aus der Musterlösung als eigene aktuelle Messung übernommen.

Für die vollständige Tag-06-Abnahme noch in einem konkreten grünen CI-Lauf `techstyle-dist` herunterladen, Wheel/sdist öffnen und den enthaltenen Quellstand prüfen. Den Lauf und die Beobachtung anschliessend im [Projektabgleich](PROJECT_AUDIT_DAYS_01_12.md) verlinken.
