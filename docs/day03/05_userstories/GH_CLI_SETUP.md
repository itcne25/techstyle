# GitHub CLI Installation & Setup

Wenn du gh CLI installierst, kann Claude automatisch alle Issues erstellen! ⚡

---

## 📦 Installation (macOS mit Homebrew)

### Schritt 1: Installiere gh CLI

```bash
brew install gh
```

Überprüfe die Installation:
```bash
gh --version
```

Sollte etwas wie "gh version 2.xx.x" ausgeben.

---

### Schritt 2: Authentifiziere dich mit GitHub

```bash
gh auth login
```

Beantworte die Fragen:
```
? What is your preferred protocol for Git operations over HTTPS? (Y/n) Y
? Authenticate Git with your GitHub credentials? (Y/n) Y
? How would you like to log in? [Paste an authentication token / Log in with a web browser]
→ Wähle "Log in with a web browser"
```

Es öffnet sich ein Browser-Fenster, gib dein GitHub-Passwort ein.

Überprüfe dich:
```bash
gh auth status
```

Sollte zeigen: "✓ Logged in to github.com as [dein-username]"

---

### Schritt 3: Konfiguriere das Repository

Stelle sicher, dass wir im richtigen Verzeichnis sind:

```bash
cd /Users/ado/tmp/git_tbz/hf/stud/devops/techstyle
git remote -v
```

Sollte ein Repository mit tbzdevops/techstyle zeigen.

---

## ✅ Alles bereit?

Wenn du das alles gemacht hast, schreib mir einfach:
```
Alles installiert und authentifiziert!
```

Dann erstelle ich ein Skript, das automatisch alle MVP1 Issues erstellt! 🚀

---

## 🆘 Probleme?

**Problem:** `gh: command not found`  
**Lösung:** 
```bash
brew install gh
brew upgrade gh
```

**Problem:** Auth funktioniert nicht  
**Lösung:** Überprüfe dass du mit dem richtigen GitHub-Account angemeldet bist

**Problem:** "Not a GitHub repository"  
**Lösung:** Stelle sicher du bist im techstyle Verzeichnis: `cd /Users/ado/tmp/git_tbz/hf/stud/devops/techstyle`

---

**Nächster Step:** Installation fertig? Dann sag Bescheid!
