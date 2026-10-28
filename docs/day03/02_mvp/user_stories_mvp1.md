# User Stories & Epics für MVP 1: Rabatt- & Gutscheincodes

**Projekt:** TechStyle eCommerce  
**Feature:** Rabatt- & Gutscheincodes (MVP Phase 1)  
**Zeitraum:** Woche 1 (11.06.-15.06.2026)  
**Team:** [Team-Name]

---

## 📊 Epic Overview

### EPIC-001: Rabatt-Code-System (MVP Phase 1)

**Beschreibung:**  
Implementierung eines einfachen Rabatt-Code-Systems, das Marketing-Teams in die Lage versetzt, sofort Kampagnen mit statischen Prozentsatz-Rabatten durchzuführen.

**Ziel:**  
Ein funktionierendes System zur Code-Generierung, -Validierung und -Anwendung im Checkout innerhalb von 1 Woche live stellen.

**Akzeptanz-Kriterien:**
- [ ] Code-Generierung funktioniert
- [ ] Codes können im Checkout eingegeben werden
- [ ] Rabatt wird korrekt berechnet
- [ ] Admin-Panel zum Code-Management existiert
- [ ] System läuft stabil in Production
- [ ] Fehlerbehandlung ist robust

**Stories im Epic:** US-101, US-102, US-103, US-104, US-105

---

## 👥 User Stories

### US-101: Code-Eingabe im Checkout

**As a** Nutzer des Online-Shops  
**I want** einen Rabatt-Code im Checkout eingeben können  
**So that** ich einen Rabatt auf meine Bestellung erhalte

**Beschreibung:**  
Als Kunde möchte ich während des Checkout-Prozesses einen Rabatt-Code eingeben können, um einen Rabatt auf meine Gesamtbestellung zu erhalten.

**Akzeptanz-Kriterien:**
- [ ] Es gibt ein Input-Feld für Rabatt-Codes im Warenkorb/Checkout
- [ ] Das Feld akzeptiert Text-Eingaben (maximal 50 Zeichen)
- [ ] Es gibt einen "Code anwenden"-Button
- [ ] Nach dem Anwenden wird der Rabatt sofort berechnet
- [ ] Fehlermeldungen werden angezeigt (ungültiger Code, bereits verwendet, etc.)
- [ ] Das Design ist responsive (Mobile & Desktop)
- [ ] Der Code ist optional (Bestellen ohne Code möglich)

**Technical Details:**
- Component: Checkout/Cart Page
- API: `POST /api/checkout/validate-code`
- Payload: `{ code: string }`
- Response: `{ valid: boolean, discount: number, message: string }`

**Aufwand:** 2-3 Stunden  
**Abhängigkeiten:** US-104 (API muss existieren)  
**Labels:** Frontend, Checkout, MVP1

---

### US-102: Rabatt-Anzeige

**As a** Nutzer  
**I want** sehen, wie viel Rabatt ich durch meinen Code erhalte  
**So that** ich die Einsparungen überblicken kann

**Beschreibung:**  
Nach dem erfolgreichen Eintragen eines Codes soll der Nutzer die genaue Rabatt-Summe und den neuen Gesamtpreis sehen.

**Akzeptanz-Kriterien:**
- [ ] Rabatt-Betrag wird angezeigt (z.B. "€ 15,00 Rabatt")
- [ ] Original-Preis und Neu-Preis sind erkennbar
- [ ] Prozentsatz wird angezeigt (z.B. "10% Rabatt")
- [ ] Die Anzeige wird sofort nach Code-Eintrag aktualisiert
- [ ] Rabatt wird in Bestellzusammenfassung angezeigt
- [ ] Ist visuell deutlich hervorgehoben

**Technical Details:**
- Component: Cart Summary / Price Display
- Calculations müssen auf Frontend & Backend validiert werden
- Einheit: EUR

**Aufwand:** 1-2 Stunden  
**Abhängigkeiten:** US-101  
**Labels:** Frontend, UX, MVP1

---

### US-103: Code-Verwaltung im Admin-Panel

**As a** Marketing-Manager  
**I want** neue Rabatt-Codes erstellen und verwalten  
**So that** ich Kampagnen durchführen kann

**Beschreibung:**  
Das Marketing-Team benötigt ein Admin-Interface, um Rabatt-Codes zu erstellen, anzuschauen und zu deaktivieren.

**Akzeptanz-Kriterien:**
- [ ] Es gibt eine Admin-Seite für Code-Verwaltung (z.B. `/admin/codes`)
- [ ] Marketing kann neue Codes erstellen mit:
  - [ ] Code-String (alphanumerisch, z.B. "SUMMER2026")
  - [ ] Rabatt-Prozentsatz (z.B. 10%)
- [ ] Codes können in einer Tabelle angezeigt werden
- [ ] Status kann gesehen werden: Aktiv / Inaktiv
- [ ] Codes können aktiviert/deaktiviert werden
- [ ] Codes können gelöscht werden
- [ ] Erstellungs- und Änderungsdatum werden angezeigt
- [ ] Nur Admins/Marketing können diese Seite sehen (Authentifizierung erforderlich)

**Technical Details:**
- Component: Admin Dashboard
- Endpoints:
  - `POST /api/admin/codes` — Code erstellen
  - `GET /api/admin/codes` — Codes auflisten
  - `PATCH /api/admin/codes/{id}` — Code aktivieren/deaktivieren
  - `DELETE /api/admin/codes/{id}` — Code löschen
- Database: `discount_codes` table

**Aufwand:** 3-4 Stunden  
**Abhängigkeiten:** US-104 (API), US-105 (Database)  
**Labels:** Backend, Admin, MVP1

---

### US-104: Code-Validierungs-API

**As a** Backend-Developer  
**I want** eine API zum Validieren von Rabatt-Codes  
**So that** der Checkout und Admin-Panel Codes prüfen können

**Beschreibung:**  
Zentrale API-Endpoint zur Validierung von Rabatt-Codes, die überprüft, ob ein Code gültig ist und den Rabatt-Betrag berechnet.

**Akzeptanz-Kriterien:**
- [ ] Endpoint `POST /api/checkout/validate-code` existiert
- [ ] Request-Payload: `{ code: string }`
- [ ] Response bei gültigem Code:
  ```json
  {
    "valid": true,
    "code": "SUMMER10",
    "discount_percentage": 10,
    "discount_amount": 15.50,
    "message": "Code valid"
  }
  ```
- [ ] Response bei ungültigem Code:
  ```json
  {
    "valid": false,
    "code": "INVALID",
    "message": "Code not found or inactive"
  }
  ```
- [ ] Code wird überprüft:
  - [ ] Existiert der Code?
  - [ ] Ist der Code aktiv?
  - [ ] Wurde der Code bereits von diesem Nutzer verwendet? (optional MVP1)
- [ ] Validierung ist schnell (<100ms)
- [ ] API ist authentifiziert (User-Token erforderlich)

**Technical Details:**
- Language: Python/Flask
- Database Query: `discount_codes` table
- Logic: Query code, check is_active, calculate discount
- Response time SLA: <100ms

**Aufwand:** 2-3 Stunden  
**Abhängigkeiten:** US-105 (Database Schema)  
**Labels:** Backend, API, MVP1

---

### US-105: Datenbank-Schema für Codes

**As a** Database-Admin  
**I want** eine Tabelle für Rabatt-Codes  
**So that** Codes persistent gespeichert werden

**Beschreibung:**  
Erstelle die notwendigen Datenbank-Tabellen und Migrationen für die Speicherung von Rabatt-Codes und deren Nutzungs-Historie.

**Akzeptanz-Kriterien:**
- [ ] Tabelle `discount_codes` existiert mit:
  - [ ] `id` (Primary Key)
  - [ ] `code` (VARCHAR 50, unique)
  - [ ] `discount_percentage` (DECIMAL, 0-100)
  - [ ] `is_active` (BOOLEAN, default true)
  - [ ] `created_at` (TIMESTAMP)
  - [ ] `updated_at` (TIMESTAMP)
  - [ ] `created_by` (Foreign Key → users)

- [ ] Tabelle `code_usage` existiert mit:
  - [ ] `id` (Primary Key)
  - [ ] `code_id` (Foreign Key → discount_codes)
  - [ ] `user_id` (Foreign Key → users)
  - [ ] `order_id` (Foreign Key → orders)
  - [ ] `discount_amount` (DECIMAL)
  - [ ] `used_at` (TIMESTAMP)

- [ ] Indizes sind erstellt:
  - [ ] `discount_codes.code` (Unique)
  - [ ] `discount_codes.is_active` (Speed up filtering)
  - [ ] `code_usage.code_id` (Foreign Key)
  - [ ] `code_usage.user_id` (Analytics)

- [ ] Migration-Script funktioniert
- [ ] Rollback-Script existiert
- [ ] Tests auf lokaler DB bestanden

**Technical Details:**
- Database: PostgreSQL (oder welche genutzt wird)
- Migration-Tool: Alembic / Flask-Migrate
- File: `migrations/versions/XXXX_add_discount_codes.py`

**Aufwand:** 1-2 Stunden  
**Abhängigkeiten:** Keine  
**Labels:** Backend, Database, MVP1

---

## 🔧 Technical Stories (nicht-User-facing)

### TS-101: Code-Generierungs-Logik

**Beschreibung:**  
Implementiere eine Hilfs-Funktion zur Generierung von eindeutigen, alphanumerischen Rabatt-Codes (z.B. "SUMMER2026", "APRIL25").

**Akzeptanz-Kriterien:**
- [ ] Funktion `generate_code()` existiert
- [ ] Codes sind eindeutig (keine Duplikate)
- [ ] Format: 8-12 alphanumerische Zeichen
- [ ] Nur Großbuchstaben (leichter zum Merken)
- [ ] Beispiele: "SUMMER10", "APRIL2526", "NEWUSER5"
- [ ] Funktion ist testbar (Unit Tests)

**Aufwand:** 1 Stunde  
**Labels:** Backend, Utility, MVP1

---

### TS-102: Code-Validierungs-Logik

**Beschreibung:**  
Implementiere die Business-Logik zur Validierung von Codes und Berechnung des Rabatts.

**Akzeptanz-Kriterien:**
- [ ] Funktion `validate_code(code: str)` existiert
- [ ] Prüft: Code existiert + is_active
- [ ] Berechnet: discount_amount = cart_total * discount_percentage / 100
- [ ] Gibt zurück: (valid: bool, discount_amount: float, error: string)
- [ ] Unit Tests: >85% Coverage
- [ ] Edge Cases getestet:
  - [ ] Code null/empty
  - [ ] Code zu lang
  - [ ] Code mit Sonderzeichen
  - [ ] Code case-insensitive?

**Aufwand:** 2 Stunden  
**Labels:** Backend, Logic, MVP1, Testing

---

## 📋 Testing Stories

### TEST-101: Unit Tests für Code-Validierung

**Beschreibung:**  
Schreibe Unit Tests für die Code-Validierungs-Logik.

**Test-Cases:**
- [ ] Valid code returns discount
- [ ] Invalid code returns error
- [ ] Inactive code returns error
- [ ] Code calculation is correct
- [ ] Empty code returns error
- [ ] Special characters handled
- [ ] Case insensitivity

**Aufwand:** 1-2 Stunden  
**Labels:** Testing, Backend, MVP1

---

### TEST-102: Integration Tests für Checkout-Flow

**Beschreibung:**  
Teste den kompletten Checkout-Flow mit Code-Eingabe.

**Test-Cases:**
- [ ] User enters valid code → discount applied
- [ ] User enters invalid code → error message
- [ ] User applies code → sees discount in summary
- [ ] User applies code → correct price calculated
- [ ] Code field is optional

**Aufwand:** 1-2 Stunden  
**Labels:** Testing, Integration, MVP1

---

### TEST-103: Manual Testing Checklist

**Beschreibung:**  
Manueller Test des kompletten Systems vor Go-Live.

**Test-Plan:**
- [ ] Code-Generierung (Admin Panel)
  - [ ] Neue Codes erstellen
  - [ ] Codes aktivieren/deaktivieren
  - [ ] Codes anzeigen
  - [ ] Codes löschen

- [ ] Code-Eingabe (Checkout)
  - [ ] Gültigen Code eingeben → Rabatt wird angewendet
  - [ ] Ungültigen Code eingeben → Error Message
  - [ ] Code löschen und neuen eingeben
  - [ ] Abbrechen (mit/ohne Code)

- [ ] Mobile & Desktop
  - [ ] Responsive Design auf Mobile
  - [ ] Input-Feld lesbar
  - [ ] Button erreichbar

- [ ] Edge Cases
  - [ ] Sehr hohe Rabatte (z.B. 99%)
  - [ ] Sehr hohe Bestellwerte
  - [ ] Mehrere Codes hintereinander

**Aufwand:** 2-3 Stunden  
**Labels:** Testing, Manual, MVP1

---

## 📅 Aufwands-Schätzung

| Story | Aufwand | Status | Assignee |
|-------|---------|--------|----------|
| TS-101 | 1h | Todo | Backend |
| US-105 | 1-2h | Todo | Backend |
| TS-102 | 2h | Todo | Backend |
| US-104 | 2-3h | Todo | Backend |
| US-103 | 3-4h | Todo | Backend |
| US-101 | 2-3h | Todo | Frontend |
| US-102 | 1-2h | Todo | Frontend |
| TEST-101 | 1-2h | Todo | Testing |
| TEST-102 | 1-2h | Todo | Testing |
| TEST-103 | 2-3h | Todo | Testing |
| **TOTAL** | **19-28h** | | |

**Team:** 2 Backend + 1 Frontend + 1 QA  
**Zeitrahmen:** 1 Woche (40 Std. verfügbar)  
**Puffer:** 12-21 Stunden ✅

---

## 🔄 Abhängigkeiten & Reihenfolge

```
TS-101 (Code Generation)
  ↓
US-105 (Database Schema) ← TS-102 (Validation Logic)
  ↓
US-104 (API Endpoint)
  ├→ US-103 (Admin Panel)
  └→ US-101 (Checkout UI) ← US-102 (Price Display)

TEST-101, TEST-102, TEST-103 (parallel nach Code)
```

**Empfohlene Reihenfolge:**
1. TS-101 & US-105 starten (parallel, unabhängig)
2. TS-102 sobald US-105 fertig
3. US-104 sobald TS-102 & US-105 fertig
4. US-103 & US-101 können parallel nach US-104
5. US-102 nach US-101
6. Tests parallel

---

## 📌 Definition of Done

Eine Story ist "Done", wenn:

- [ ] Code ist geschrieben und committed
- [ ] Alle Akzeptanz-Kriterien erfüllt
- [ ] Unit Tests geschrieben (wo passend)
- [ ] Code Review durchgeführt & approved
- [ ] Tests bestanden (lokal)
- [ ] Merge in develop-Branch
- [ ] Dokumentation aktualisiert (falls nötig)
- [ ] Team hat Feature gesehen / akzeptiert

---

## 🎯 Kanban Board Setup

**Spalten für GitHub Project:**
1. **Backlog** — Nicht priorisiert
2. **Ready for Development** — Ready, aber nicht begonnen
3. **In Development** — Aktuell in Bearbeitung
4. **Code Review** — Waiting for Review
5. **Testing** — In Test-Phase
6. **Ready for Deployment** — Testing bestanden, ready for Production
7. **Done** — In Production

**Initial Status für MVP1 Stories:**
- Alle TS/US/TEST Stories: **Ready for Development**
- Epic: **In Development** (nach Start)

---

**Dokument:** MVP 1 User Stories & Epics  
**Version:** 1.0 – Final  
**Datum:** 11.06.2026  
**Team:** [Team-Name]
