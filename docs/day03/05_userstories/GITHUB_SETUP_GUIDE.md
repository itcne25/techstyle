# GitHub Project Setup Guide – MVP 1 Rabatt-Codes

**Ziel:** Aufgabe 4 & 5 durchführen - Kanban Board anpassen und User Stories erstellen

**Projekt:** https://github.com/orgs/tbzdevops/projects/1

---

## 🎯 Schritt 1: GitHub Project überprüfen

1. Gehe zu https://github.com/orgs/tbzdevops/projects/1
2. Überprüfe, dass das Kanban Board folgende Spalten hat:
   - ✅ Backlog
   - ✅ To Do / Ready for Development
   - ✅ In Progress / In Development
   - ✅ Code Review / Testing
   - ✅ Ready for Deployment
   - ✅ Done

Falls noch nicht vorhanden, erstelle diese Spalten:
- Klick "+" neben der letzten Spalte
- Wähle "Create column" oder "Add column"
- Gib den Namen ein und bestätige

---

## 📋 Schritt 2: Issues/User Stories erstellen

### Option A: Direkt im GitHub Project (empfohlen für schnelle Erstellung)

1. Gehe zum Project Dashboard
2. Klick "Create issue" Button
3. Für jede User Story folgende Informationen eintragen:

#### Issue-Vorlage für User Stories:

```
Title: US-101: Code-Eingabe im Checkout

Description:
As a Nutzer des Online-Shops
I want einen Rabatt-Code im Checkout eingeben können
So that ich einen Rabatt auf meine Bestellung erhalte

## Technical Details
- Component: Checkout/Cart Page
- API: POST /api/checkout/validate-code
- Estimated: 2-3 hours

## Acceptance Criteria
- [ ] Input-Feld für Rabatt-Codes im Warenkorb vorhanden
- [ ] Feld akzeptiert Text-Eingaben (maximal 50 Zeichen)
- [ ] Button "Code anwenden" vorhanden
- [ ] Rabatt wird sofort berechnet nach Klick
- [ ] Fehlermeldungen werden angezeigt
- [ ] Design ist responsive (Mobile & Desktop)
- [ ] Code ist optional (Bestellen ohne Code möglich)
```

### Option B: Über GitHub CLI (wenn verfügbar)

```bash
gh issue create \
  --title "US-101: Code-Eingabe im Checkout" \
  --body "As a Nutzer..." \
  --label "MVP1,Frontend,Checkout"
```

---

## 📌 User Stories für MVP 1 – Erstelle diese Issues:

### Priorität 1 (Müssen diese Woche fertig sein):

| ID | Titel | Assignee | Aufwand | Labels |
|----|----|----------|---------|--------|
| TS-101 | Code-Generierungs-Logik | Backend | 1h | Backend, Utility, MVP1 |
| US-105 | Datenbank-Schema für Codes | Backend | 1-2h | Backend, Database, MVP1 |
| TS-102 | Code-Validierungs-Logik | Backend | 2h | Backend, Logic, MVP1 |
| US-104 | Code-Validierungs-API | Backend | 2-3h | Backend, API, MVP1 |
| US-103 | Code-Verwaltung Admin-Panel | Backend | 3-4h | Backend, Admin, MVP1 |
| US-101 | Code-Eingabe im Checkout | Frontend | 2-3h | Frontend, Checkout, MVP1 |
| US-102 | Rabatt-Anzeige | Frontend | 1-2h | Frontend, UX, MVP1 |

### Priorität 2 (Testing & Validation):

| ID | Titel | Assignee | Aufwand | Labels |
|----|----|----------|---------|--------|
| TEST-101 | Unit Tests für Code-Validierung | QA | 1-2h | Testing, Backend, MVP1 |
| TEST-102 | Integration Tests Checkout | QA | 1-2h | Testing, Integration, MVP1 |
| TEST-103 | Manual Testing Checklist | QA | 2-3h | Testing, Manual, MVP1 |

### Epic:

| ID | Titel | Abhängigkeiten |
|----|-------|-----------------|
| EPIC-001 | Rabatt-Code-System (MVP Phase 1) | TS-101, US-105, TS-102, US-104, US-103, US-101, US-102 |

---

## 🔗 Schritt 3: Issues ins Kanban Board hinzufügen

Nach dem Erstellen der Issues:

1. Öffne das Project Dashboard
2. Für jede Story:
   - Klick auf die Story
   - Setze den Status auf "Ready for Development" (rechte Seite → Status wählen)
   - Ordne sie der richtige Spalte zu (per Drag & Drop möglich)

**Initiales Setup:**
```
Backlog:                    [leer]
Ready for Development:      [TS-101, US-105, TS-102, US-104, US-103, US-101, US-102, TEST-101, TEST-102, TEST-103]
In Development:             [leer] (wird während Sprint gefüllt)
Code Review:                [leer]
Testing:                    [leer]
Ready for Deployment:       [leer]
Done:                       [leer]
```

---

## 🏷️ Schritt 4: Labels erstellen (falls nicht vorhanden)

Im GitHub Repository > Labels, erstelle diese Labels:

- `MVP1` — Part of MVP Phase 1
- `Backend` — Backend work
- `Frontend` — Frontend work
- `Testing` — QA/Testing
- `Database` — Database changes
- `Admin` — Admin interface
- `API` — API endpoint
- `Checkout` — Checkout process
- `UX` — User experience
- `Utility` — Utility/Helper
- `Integration` — Integration test
- `Manual` — Manual testing
- `Logic` — Business logic
- `High Priority` — Must do this week

---

## 👥 Schritt 5: Team-Zuweisung

Weise die Stories dem Team zu (in jedem Issue):

**Beispiel-Zuweisung für 3er Team:**

**Backend-Entwickler 1:**
- TS-101 (Code Generation)
- US-105 (Database)
- TS-102 (Validation Logic)

**Backend-Entwickler 2:**
- US-104 (API)
- US-103 (Admin Panel)

**Frontend-Entwickler:**
- US-101 (Checkout UI)
- US-102 (Price Display)

**QA/Testing (parallel):**
- TEST-101, TEST-102, TEST-103

---

## 🔄 Schritt 6: Kanban Board Daily Management

**Jeden Tag:**
1. Oben im Project: Refresh zur Überprüfung von Updates
2. Stories verschieben, wenn Status sich ändert
3. Blockers dokumentieren im Issue-Kommentar

**Status-Übergänge:**
```
Ready for Development → (Assignee klickt "Start Work") → In Development
In Development → (Code fertig) → Code Review
Code Review → (Approved) → Testing
Testing → (Passed) → Ready for Deployment
Ready for Deployment → (Nach Go-Live) → Done
```

---

## ✅ Definition of Done Checklist

Bevor ein Issue geschlossen wird, überprüfe:

- [ ] Alle Akzeptanz-Kriterien erfüllt
- [ ] Code ist geschrieben & committed
- [ ] Unit Tests bestanden (>85% Coverage falls Code)
- [ ] Code Review approved
- [ ] Dokumentation aktualisiert (falls nötig)
- [ ] Team hat Feature validiert
- [ ] Issue ist mit "Done" markiert

---

## 📊 Go-Live Checkliste (Freitag 15.06.)

Bevor wir MVP 1 in Production gehen:

- [ ] Alle Issues sind im Status "Done"
- [ ] Tests bestanden (Unit + Integration + Manual)
- [ ] Code ist gemergt in `main`/`production` Branch
- [ ] Deployment-Prozess durchgeführt
- [ ] System läuft stabil in Production
- [ ] Fehler-Monitoring eingerichtet
- [ ] Marketing weiß, dass es live ist
- [ ] Erste Testkodes funktionieren

---

## 🆘 Troubleshooting

**Problem:** Kann keine Issues erstellen  
**Lösung:** Überprüfe, dass du Schreib-Zugriff auf das Projekt hast

**Problem:** Spalten sind nicht sichtbar  
**Lösung:** Refresh die Seite oder überprüfe die Project-Einstellungen

**Problem:** Issues werden nicht ins Board übernommen  
**Lösung:** Stelle sicher, dass du ein "Status" Feld im Project hast und die Issues diesem zuweist

---

## 📞 Support

Falls Fragen:
- Siehe User Stories Dokumentation: `docs/day03/02_mvp/user_stories_mvp1.md`
- MVP Definition: `docs/day03/02_mvp/selected_feature_mvp.md`
- Kontakt: DevOps-Team (Slack: #techstyle-development)

---

**Erstellt:** 11.06.2026  
**Status:** Einsatzbereit
