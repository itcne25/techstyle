# Tag 14: Deployment nach AWS

## Ausgangsstand

**Weg A:** Dieses Team-Repository (`main`) wird weitergeführt. Es enthält bereits den Tag-13-Stand mit `Dockerfile`, einem Compose-Stack aus `web` und PostgreSQL-`db` sowie `/healthz`. Es war deshalb kein Wechsel auf einen Musterlösungsbranch nötig. Für den Server kommt `docker-compose.prod.yml` hinzu: Das Webimage wird aus ECR gezogen, statt auf EC2 gebaut zu werden. Der interne Webport bleibt 5001; öffentlich ist Port 80 erreichbar. Tests laufen mit `python -m pip install -r requirements-container.txt pytest` und `python -m pytest tests/ -v`. Das bereits angelegte ECR-Repository heisst `ts/prod-images` statt `techstyle` wie in der Aufgaben-Vorlage. Die vorhandene EC2 heisst `techstyle-ec2` und wurde mit dem Key Pair `labuser` statt `vockey` gestartet.

## Pipeline-Architektur

```mermaid
flowchart LR
    A[Push auf main] --> B[Python-Tests und Container-Smoketest]
    B --> C[Docker-Image bauen und mit Commit-SHA nach ECR pushen]
    C --> D[Per SSH auf EC2: Compose pull und up]
    D --> E[HTTP-Healthcheck auf Port 80]
```

Der Workflow `.github/workflows/deploy-aws.yml` verknüpft die Jobs mit `needs`. Schlagen Tests oder der Container-Smoketest fehl, wird kein Image veröffentlicht. ECR speichert das Image unter `ts/prod-images:<vollständiger Commit-SHA>`; damit ist der ausgerollte Code eindeutig zuordenbar. Bei einem erneut ausgeführten älteren Lauf wird das vorhandene SHA-Image wiederverwendet, weil das Repository unveränderliche Tags verwendet. Der Deployment-Job kopiert nur Compose und eine zur Laufzeit erzeugte `.env` auf EC2, meldet Docker an ECR an und startet den Stack mit `--wait`. Das PostgreSQL-Volume bleibt bei einem Imagewechsel erhalten. Ein lokaler und ein öffentlicher Healthcheck müssen erfolgreich sein, bevor der Lauf grün wird.

## Einmalige Einrichtung im Learner Lab

1. Lab starten, Region `us-east-1` wählen. Das private ECR-Repository `ts/prod-images` ist bereits angelegt.
2. Die vorhandene EC2 `techstyle-ec2` (`t3.small`) hat die öffentliche IPv4-Adresse `13.218.35.147` und verwendet das Key Pair `labuser`. Das User Data enthält `scripts/ec2-user-data.sh`. Der lokale Schlüssel `labuser.pem` wurde anhand seines öffentlichen Fingerabdrucks mit dem AWS-Key-Pair abgeglichen. Docker und Compose wurden per SSH geprüft: `ssh -i <PFAD-ZU-labuser.pem> ubuntu@13.218.35.147 docker compose version`.
3. Security Group `launch-wizard-1` für diese Übung: eingehend TCP 80 von `0.0.0.0/0` für den öffentlichen Shop und TCP 22 von `0.0.0.0/0` für das Deployment per GitHub-Runner. Die Runner-IP wechselt; «My IP» für SSH allein lässt die Pipeline scheitern. Die offene SSH-Regel ist nur für die kurze Lab-Übung geeignet. Für einen länger betriebenen Dienst SSH per kurzlebiger Runner-IP-Regel oder über einen festen Runner/SSM absichern. Eingehend weder 5001 noch 5432 öffnen: Docker veröffentlicht nur Port 80, PostgreSQL bleibt intern. Für diesen HTTP-Stack ist kein eingehender Port 443 nötig. Ausgehend kann die Standardregel für den Download von Paketen und Images bestehen bleiben.
4. In **GitHub → Settings → Secrets and variables → Actions** diese Repository-Secrets setzen:

| Secret | Inhalt |
| --- | --- |
| `AWS_ACCESS_KEY_ID` | Learner-Lab-Zugangsdaten aus AWS Details |
| `AWS_SECRET_ACCESS_KEY` | Learner-Lab-Zugangsdaten aus AWS Details |
| `AWS_SESSION_TOKEN` | Learner-Lab-Session-Token |
| `EC2_HOST` | Aktuelle öffentliche IPv4-Adresse der Instanz, ohne `http://`; derzeit `13.218.35.147` |
| `EC2_SSH_PRIVATE_KEY` | Vollständiger Inhalt der geprüften privaten Datei `labuser.pem` zum Key Pair `labuser` |
| `EC2_KNOWN_HOSTS` | Verifizierter Hostschlüssel als Zeile `<IP> ssh-ed25519 <öffentlicher Schlüssel>` |
| `POSTGRES_PASSWORD` | Einmalig erzeugter Hexwert mit 64 Zeichen |
| `SECRET_KEY` | Ein anderer Hexwert mit 64 Zeichen für Flask-Sessions |

Die zwei Hexwerte erzeugt man jeweils mit `python -c "import secrets; print(secrets.token_hex(32))"`. `POSTGRES_PASSWORD` nach dem ersten Start **nicht** ändern: Das vorhandene Datenbank-Volume behält das ursprüngliche Passwort. Für `EC2_KNOWN_HOSTS` den öffentlichen Hostschlüssel auf der Instanz mit `sudo cat /etc/ssh/ssh_host_ed25519_key.pub` über eine bereits verifizierte Verbindung oder die EC2-Konsole ablesen. Der Secret-Wert beginnt mit der aktuellen IP, gefolgt vom Inhalt dieser Datei. Der für diese Instanz gelesene ED25519-Schlüssel wurde auch mit dem AWS-EC2-Systemlog abgeglichen. Private Schlüssel, AWS-Zugangsdaten und `.env` gehören nie in Git.

## Bedienung und Prüfung

Ein Push auf `main` startet den Workflow **Tag 14 - Deployment auf AWS**. Der erste Lauf benötigt die fertige EC2-Instanz, das ECR-Repository und alle Secrets. Nach einem grünen Lauf `http://<EC2_HOST>/` und `http://<EC2_HOST>/healthz` öffnen. Das Image mit dem SHA-Tag im ECR-Repository prüfen. Eine sichtbare Änderung an `templates/index.html` und ein weiterer Push zeigen, dass das Deployment ohne SSH-Handarbeit funktioniert.

Bei einer neuen Lab-Session die drei `AWS_*`-Secrets erneuern. Falls die Instanz eine neue IP hat, `EC2_HOST` und die IP in `EC2_KNOWN_HOSTS` aktualisieren. Die SSH- und Datenbank-Secrets bleiben nur gültig, solange Instanz, Key Pair und Datenbank-Volume dieselben sind. Für Logs: `ssh -i <PFAD-ZU-labuser.pem> ubuntu@<EC2_HOST>` und danach `cd ~/techstyle && docker compose --env-file .env -f docker-compose.prod.yml logs --tail 50 web`. Den Zustand zeigt derselbe Befehl mit `ps` statt `logs --tail 50 web`.

Für ein Rollback den erfolgreichen Workflowlauf eines älteren Commits in GitHub Actions mit **Re-run all jobs** erneut ausführen. Der SHA dieses Laufs wird in ECR gefunden und das vorhandene Image auf EC2 ausgerollt. Danach Shop und `/healthz` erneut prüfen. Das ist ein Image-Rollback; Datenbankschema und Daten werden dadurch nicht zurückgesetzt. Für spätere Schemaänderungen braucht es einen separaten Migrations- und Rollback-Plan.

## Nachweise

Die Angaben stammen aus den GitHub-Actions-Läufen und den Prüfungen auf EC2.

- Erster grüner Workflowlauf: [Versuch 3 des Commits `f822899`](https://github.com/itcne25/techstyle/actions/runs/40673898995).
- Zweiter grüner Workflowlauf nach sichtbarer Änderung: [Commit `9d260c1`](https://github.com/itcne25/techstyle/actions/runs/40686928216). Vorher fehlte die Überschrift „TechStyle Collection“, danach war sie auf EC2 sichtbar.
- ECR-Image-URI des zweiten Laufs: `524744059708.dkr.ecr.us-east-1.amazonaws.com/ts/prod-images:9d260c1efbb7810ec06dac8eab669bfcbe3b4e9b`.
- Shop-URL: <http://13.218.35.147/>; der Shop wurde im Browser geöffnet. `/healthz` antwortete auf EC2 mit `{"status":"ok"}`. Der öffentliche Healthcheck des GitHub-Workflows war erfolgreich.
- Rollback auf `f822899`: **bewusst nicht getestet**; hierfür wird kein erfolgreicher Nachweis beansprucht.

## Ausblick: ECS

Mit ECS würde GitHub Actions nach dem ECR-Push eine neue Task-Definition mit dem SHA-Image registrieren und den ECS-Service aktualisieren. ECS übernimmt Platzierung, Ersatz ausgefallener Tasks und Healthchecks. SSH, manuelles Compose auf EC2 und die lokale `.env` entfallen. Für PostgreSQL wäre dann ein eigenständiger persistenter Dienst wie RDS sinnvoll; das lokale Compose-Volume eines einzelnen Servers wäre keine geeignete dauerhafte ECS-Datenhaltung.
