# Release-Versionierung

TechStyle verwendet Semantic Versioning im Format `MAJOR.MINOR.PATCH`. Inkompatible Änderungen erhöhen MAJOR, neue kompatible Funktionen MINOR und kompatible Fehlerkorrekturen PATCH. Der Release-Prozess und die Verantwortlichkeiten stehen in [CONTRIBUTING.md](../CONTRIBUTING.md).

Die Python-Paketversion steht in `pyproject.toml`. Der [GitHub-Release `v1.0.0`](https://github.com/itcne25/techstyle/releases/tag/v1.0.0) existiert und zeigt auf `daf4c88`. Dieser Stand enthält nur die damalige Dokumentationsbasis, noch keine Shop-Anwendung. Der bestehende veröffentlichte Tag wird nicht verschoben. Die aus der Musterlösung übernommene Paketversion `1.0.0` ist noch keinem eigenen Shop-Release zugeordnet; vor dem nächsten Release sind eine passende neue Version und Release Notes festzulegen.

Für das Tag-14-Deployment wird ein anderer Identifikator verwendet: Das ECR-Image trägt den vollständigen Commit-SHA. Damit lässt sich eine ausgerollte Version eindeutig einem Quellstand zuordnen, auch zwischen SemVer-Releases. Der SHA ersetzt nicht die fachliche Release-Versionierung eines dauerhaft verteilten Python-Pakets.
