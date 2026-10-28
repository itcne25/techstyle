# Contributing to TechStyle

Dieses Dokument beschreibt den Git-Workflow, die Branching- und Merging-Strategie sowie die Release-Versionierung für TechStyle.

## Branching-Strategie

Wir verwenden für die Entwicklung des eCommerce-Projekts den **GitHub Flow**. Die Strategie passt zu kurzen Entwicklungszyklen und ermöglicht, Änderungen vor dem Merge zu prüfen.

- `main`: Produktionsnaher, jederzeit auslieferbarer Stand
- `feature/<name>`: Neue Funktionen
- `bugfix/<name>`: Korrekturen ohne Produktionsnotfall
- `hotfix/<name>`: Dringende Korrekturen für den Produktionsstand
- `release/v<MAJOR>.<MINOR>.<PATCH>`: Optionaler Branch für die Vorbereitung eines Releases

Die Branch-Namen werden klein geschrieben und verwenden Bindestriche, zum Beispiel `feature/payment-integration` oder `bugfix/cart-total`.

Die Branches `day_X_checkpoint` und `day_X_solution` dienen dem DevOps-Kurs als Checkpoint- und Lösungszweige. Sie ersetzen nicht den Entwicklungsworkflow des Projekts.

## Entwicklungsworkflow

1. Aktuellen Stand holen:

   ```bash
   git checkout main
   git pull --ff-only origin main
   ```

2. Einen kurzen Arbeitsbranch erstellen:

   ```bash
   git checkout -b feature/<name>
   ```

3. Eine logisch abgeschlossene Änderung umsetzen, lokal testen und als atomaren Commit speichern.

4. Den Branch pushen und einen Pull Request nach `main` erstellen:

   ```bash
   git push -u origin feature/<name>
   ```

5. Review-Feedback einarbeiten, die CI-Prüfungen abwarten und erst danach mergen.

6. Den Branch nach dem Merge löschen und den lokalen Stand aktualisieren:

   ```bash
   git checkout main
   git pull --ff-only origin main
   git branch -d feature/<name>
   ```

Direkte Pushes auf `main` sind nicht vorgesehen. Änderungen sollen über Pull Requests nachvollziehbar und reviewbar bleiben.

## Merge-Strategie

Die Merge-Methode richtet sich nach der Art der Änderung:

| Methode | Verwendung |
| --- | --- |
| Squash Merge | Standard für Pull Requests mit mehreren Arbeits- oder Zwischen-Commits. Der fertige Stand erscheint als ein fachlich klarer Commit auf `main`. |
| Merge Commit | Wenn die Entwicklung eines länger laufenden Branches oder eine fachliche Merge-Historie nachvollziehbar bleiben muss. |
| Fast-Forward | Für einfache, lineare Änderungen ohne parallele Commits auf `main`, sofern der Repository-Schutz dies erlaubt. |
| Rebase | Lokal, um einen Arbeitsbranch vor dem Pull Request auf den aktuellen Stand von `main` zu bringen. Nicht auf bereits gemeinsam verwendeten oder veröffentlichten Branches. |

Ein Rebase schreibt die Historie um. Deshalb wird kein `git push --force` auf `main` verwendet. Falls ein bereits gepushter Commit rückgängig gemacht werden muss, wird `git revert` verwendet, damit die gemeinsame Historie erhalten bleibt.

## Pull Requests und Reviews

Jeder Pull Request beschreibt mindestens:

- Zweck und Umfang der Änderung
- Verknüpfte Aufgabe oder Issue
- Durchgeführte Tests und deren Ergebnis
- Auswirkungen auf Konfiguration, Datenbank oder Deployment
- Bekannte Einschränkungen und offene Punkte

Für das Mergen gelten folgende Regeln:

- Mindestens eine Person aus dem Team muss den Pull Request reviewen.
- Die CI-Prüfungen müssen erfolgreich sein.
- Offene Review-Kommentare müssen beantwortet oder gelöst sein.
- Der Autor entscheidet nicht allein über das Mergen des eigenen Pull Requests.
- Konflikte werden vom Autor des Pull Requests mit Unterstützung der betroffenen Personen gelöst und anschliessend erneut geprüft.

## Commit-Messages

Wir verwenden Conventional Commits. Ein Commit beschreibt genau eine logische Änderung:

```text
<type>(<scope>): <kurze Beschreibung>
```

Erlaubte Typen sind unter anderem:

- `feat`: Neue Funktion
- `fix`: Fehlerbehebung
- `docs`: Dokumentation
- `refactor`: Umstrukturierung ohne Verhaltensänderung
- `test`: Tests
- `chore`: Wartung, Build oder Abhängigkeiten
- `merge`: Auflösen eines fachlichen Merge-Konflikts

Beispiele:

```text
feat(cart): add item quantity validation
fix(auth): handle missing session safely
docs: add release process
```

Commit-Messages werden im Imperativ und auf Englisch formuliert. Geheimnisse, Passwörter, lokale Datenbanken, virtuelle Umgebungen und generierte Dateien dürfen nicht committed werden.

## Tests und lokale Prüfung

Vor dem Erstellen eines Pull Requests muss die Anwendung lokal gestartet und der betroffene Workflow geprüft werden:

```bash
./run_dev.sh
```

Mindestens die geänderten Funktionen sind manuell zu testen. Neue oder geänderte Logik soll zusätzlich durch automatisierte Tests abgedeckt werden, sobald eine Test-Suite vorhanden ist. Fehlerhafte Tests oder bekannte Einschränkungen werden im Pull Request dokumentiert.

## Release-Versionierung

TechStyle verwendet Semantic Versioning (SemVer) im Format `MAJOR.MINOR.PATCH` und annotierte Git-Tags mit führendem `v`.

- **MAJOR**: Inkompatible Änderungen an API, Datenmodell oder Bedienverhalten, zum Beispiel `v1.4.2` -> `v2.0.0`
- **MINOR**: Neue, rückwärtskompatible Funktionen, zum Beispiel `v1.4.2` -> `v1.5.0`
- **PATCH**: Rückwärtskompatible Fehler- oder Sicherheitskorrekturen, zum Beispiel `v1.4.2` -> `v1.4.3`

### Release-Prozess

1. Alle vorgesehenen Änderungen werden in `main` integriert und erfolgreich geprüft.
2. Für größere Releases kann ein Branch `release/vX.Y.Z` erstellt werden. Dort sind nur Dokumentation, Versionsanpassungen und Fehlerkorrekturen erlaubt.
3. Release Notes werden vorbereitet und enthalten mindestens:
   - Zusammenfassung der Änderungen
   - Neue Funktionen
   - Behobene Fehler und Sicherheitskorrekturen
   - Bekannte Einschränkungen
   - Migrations- oder Upgrade-Hinweise
4. Der Release-Tag wird auf dem finalen Commit von `main` erstellt:

   ```bash
   git checkout main
   git pull --ff-only origin main
   git tag -a v1.0.0 -m "Release v1.0.0"
   git push origin v1.0.0
   ```

5. Auf GitHub wird ein Release zum Tag erstellt und mit den Release Notes dokumentiert.
6. Der Release-Stand wird nach der Veröffentlichung kurz smoke-getestet. Bei einem kritischen Fehler wird ein Patch-Release erstellt.

Tags sind unveränderlich. Ein bereits veröffentlichter Tag wird nicht verschoben oder überschrieben. Für eine Korrektur wird die nächste passende SemVer-Version veröffentlicht.

### Release-Notes-Vorlage

```markdown
# v1.2.0 - Kurzer Release-Titel

## Zusammenfassung
Was ist in diesem Release enthalten?

## Neue Funktionen
- ...

## Behobene Fehler
- ...

## Bekannte Einschränkungen
- ...

## Migration und Upgrade
- ...
```

## Konflikte und Rückgängigmachen

Vor einer Konfliktlösung wird der Arbeitsbranch aktualisiert:

```bash
git checkout main
git pull --ff-only origin main
git checkout feature/<name>
git rebase main
```

Konfliktmarker werden vollständig entfernt, die betroffene Funktion wird getestet und die Konfliktlösung wird im Pull Request beschrieben. Für bereits gepushte gemeinsame Commits gilt:

```bash
git revert <commit>
```

`git reset --hard` ist nur für lokale, noch nicht geteilte Arbeit zulässig und darf nicht gegen `main` oder einen gemeinsamen Remote-Branch verwendet werden.