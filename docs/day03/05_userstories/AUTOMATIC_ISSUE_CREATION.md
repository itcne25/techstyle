# ⚡ Automatische Issue-Erstellung mit gh CLI

So erstellst du alle MVP1 Issues mit einem einzigen Befehl! 

---

## 🚀 Quick Start (3 Schritte)

### 1️⃣ Installiere GitHub CLI

```bash
brew install gh
```

### 2️⃣ Authentifiziere dich

```bash
gh auth login
# Wähle "Log in with a web browser"
# Gib dein GitHub-Passwort ein
```

Überprüfe:
```bash
gh auth status
```

### 3️⃣ Führe das Script aus

```bash
cd /Users/ado/tmp/git_tbz/hf/stud/devops/techstyle
./scripts/create_mvp1_issues.sh
```

Das wars! ✅ Alle 10 Issues werden automatisch erstellt!

---

## 📊 Was passiert?

Das Script erstellt automatisch:

```
✅ EPIC-001: Rabatt-Code-System
├─ ✅ TS-101: Code-Generierungs-Logik
├─ ✅ US-105: Datenbank-Schema
├─ ✅ TS-102: Code-Validierungs-Logik
├─ ✅ US-104: Code-Validierungs-API
├─ ✅ US-103: Admin-Panel
├─ ✅ US-101: Checkout Code-Input
├─ ✅ US-102: Rabatt-Anzeige
├─ ✅ TEST-101: Unit Tests
├─ ✅ TEST-102: Integration Tests
└─ ✅ TEST-103: Manual Testing
```

Alle mit:
- ✅ Eindeutiger Titel (US-101, etc.)
- ✅ Vollständige Beschreibung
- ✅ Akzeptanz-Kriterien (als Checkboxes)
- ✅ Geschätzter Aufwand
- ✅ Abhängigkeiten
- ✅ Labels (MVP1, Backend, Frontend, etc.)
- ✅ Automatisch ins GitHub Project eingebunden

---

## 🎯 Nach der Erstellung

1. **Öffne das GitHub Project:**
   ```
   https://github.com/orgs/tbzdevops/projects/1
   ```

2. **Überprüfe dass alle Issues vorhanden sind**

3. **Verschiebe Issues in die richtige Spalte:**
   - Alle sollten in "Ready for Development" Spalte sein
   - Wenn nicht, verschiebe sie manuell (Drag & Drop)

4. **Starte Montag um 09:00 mit der Entwicklung**

---

## ⚙️ Script Details

**Was der Script tut:**
- ✅ Überprüft gh CLI Installation
- ✅ Überprüft GitHub Authentifizierung
- ✅ Erstellt alle Issues sequenziell
- ✅ Setzt alle Labels korrekt
- ✅ Bindet alles ins Project ein
- ✅ Zeigt Progress an

**Was der Script NICHT tut:**
- ❌ Assigned Issues nicht automatisch (du kannst das im Project machen)
- ❌ Verschieben Issues nicht in Spalten (WIP-Limits einrichten ist auch manuell)

**Dauer:** ~30 Sekunden

---

## 🔧 Manuell einzelne Issues erstellen

Falls du nur eine Story manuell erstellen möchtest:

```bash
gh issue create \
  --title "US-101: Code-Eingabe im Checkout" \
  --body "As a Nutzer..." \
  --label "MVP1,Frontend" \
  --project 1
```

---

## ❌ Probleme?

**Problem:** Script-Fehler bei Ausführung  
**Lösung:**
```bash
bash ./scripts/create_mvp1_issues.sh  # Explizit mit bash ausführen
```

**Problem:** `gh: command not found`  
**Lösung:**
```bash
brew install gh
brew upgrade gh
```

**Problem:** Authentifizierung fehlgeschlagen  
**Lösung:**
```bash
gh auth logout
gh auth login  # Neu anmelden
```

**Problem:** Issues werden nicht ins Projekt eingebunden  
**Lösung:** Überprüfe dass `--project 1` richtig gesetzt ist in deinem Projekt

---

## 📚 Referenzen

- **GitHub CLI Docs:** https://cli.github.com/manual/
- **gh issue create:** https://cli.github.com/manual/gh_issue_create
- **Unser Setup Guide:** `docs/day03/GH_CLI_SETUP.md`

---

## 🎯 Fertig!

Nach Ausführung:
1. Alle Issues sind im GitHub Project
2. Team kann sofort Montag starten
3. Kanban Board ist ready
4. Go-Live Freitag ist on-track 🚀

---

**Status:** ⚡ Bereit zum Einsatz  
**Komplexität:** Sehr einfach (3 Schritte)  
**Zeit:** <1 Minute
