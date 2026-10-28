#!/bin/bash

# Script: Erstelle alle MVP1 User Stories & Issues im GitHub Project
# Verwendung: ./scripts/create_mvp1_issues.sh
# Voraussetzung: gh CLI installiert & authentifiziert (gh auth login)

set -e

echo "🚀 Starte MVP1 Issues Erstellung..."
echo "=================================="
echo ""

# Farben für Output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Überprüfe gh CLI
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI nicht gefunden. Installiere mit: brew install gh"
    exit 1
fi

# Überprüfe auth
if ! gh auth status &> /dev/null; then
    echo "❌ Nicht authentifiziert. Führe aus: gh auth login"
    exit 1
fi

echo -e "${BLUE}✓ gh CLI installiert und authentifiziert${NC}"
echo ""

# Repository info
REPO=tbzdevops/techstyle
echo -e "${BLUE}Repository: $REPO${NC}"
echo ""

# ============================================================
# Erstelle Labels falls noch nicht vorhanden
# ============================================================
echo -e "${BLUE}Überprüfe und erstelle Labels...${NC}"

LABELS=(
  "MVP1"
  "Epic"
  "Rabatt-Codes"
  "Backend"
  "Frontend"
  "Testing"
  "Database"
  "Admin"
  "API"
  "Checkout"
  "UX"
  "Utility"
  "Integration"
  "Manual"
  "Logic"
)

for label in "${LABELS[@]}"; do
  # Versuche Label zu erstellen (Fehler wird ignoriert wenn es schon existiert)
  gh label create "$label" --force 2>/dev/null || true
done

echo -e "${GREEN}✓ Labels vorbereitet${NC}"
echo ""

# ============================================================
# EPIC-001: Rabatt-Code-System
# ============================================================
echo -e "${BLUE}Erstelle EPIC-001...${NC}"
gh issue create \
  --title "EPIC-001: Rabatt-Code-System (MVP Phase 1)" \
  --body "# Rabatt-Code-System MVP Phase 1

Eine umfassende Implementierung eines einfachen Rabatt-Code-Systems für Marketing-Kampagnen.

## Beschreibung
Implementierung eines einfachen Rabatt-Code-Systems, das Marketing-Teams in die Lage versetzt, sofort Kampagnen mit statischen Prozentsatz-Rabatten durchzuführen.

## Ziel
Ein funktionierendes System zur Code-Generierung, -Validierung und -Anwendung im Checkout innerhalb von 1 Woche live stellen.

## Akzeptanz-Kriterien
- [ ] Code-Generierung funktioniert
- [ ] Codes können im Checkout eingegeben werden
- [ ] Rabatt wird korrekt berechnet
- [ ] Admin-Panel zum Code-Management existiert
- [ ] System läuft stabil in Production
- [ ] Fehlerbehandlung ist robust

## Stories im Epic
- US-101: Code-Eingabe im Checkout
- US-102: Rabatt-Anzeige
- US-103: Code-Verwaltung Admin-Panel
- US-104: Code-Validierungs-API
- US-105: Datenbank-Schema
- TS-101: Code-Generierungs-Logik
- TS-102: Code-Validierungs-Logik
- TEST-101: Unit Tests
- TEST-102: Integration Tests
- TEST-103: Manual Testing

## Timeline
- **Start:** Montag 11.06.2026
- **Go-Live:** Freitag 15.06.2026
" \
  --label "MVP1,Epic,Rabatt-Codes" \
  --project 2

EPIC_ID=$(gh issue list --label "MVP1,Epic" --limit 1 --json number --jq '.[0].number')
echo -e "${GREEN}✓ EPIC-001 erstellt (Issue #$EPIC_ID)${NC}"
echo ""

# ============================================================
# TS-101: Code-Generierungs-Logik
# ============================================================
echo -e "${BLUE}Erstelle TS-101...${NC}"
gh issue create \
  --title "TS-101: Code-Generierungs-Logik" \
  --body "# Code-Generierungs-Logik

## Beschreibung
Implementiere eine Hilfs-Funktion zur Generierung von eindeutigen, alphanumerischen Rabatt-Codes.

## Akzeptanz-Kriterien
- [ ] Funktion \`generate_code()\` existiert
- [ ] Codes sind eindeutig (keine Duplikate)
- [ ] Format: 8-12 alphanumerische Zeichen
- [ ] Nur Großbuchstaben (leichter zum Merken)
- [ ] Beispiele: 'SUMMER10', 'APRIL2526', 'NEWUSER5'
- [ ] Funktion ist testbar (Unit Tests)

## Geschätzter Aufwand
1 Stunde

## Abhängigkeiten
Keine
" \
  --label "MVP1,Backend,Utility" \
  --project 2

echo -e "${GREEN}✓ TS-101 erstellt${NC}"
echo ""

# ============================================================
# US-105: Datenbank-Schema
# ============================================================
echo -e "${BLUE}Erstelle US-105...${NC}"
gh issue create \
  --title "US-105: Datenbank-Schema für Codes" \
  --body "# Datenbank-Schema für Codes

## Als Developer
Ich möchte eine Tabelle für Rabatt-Codes, damit Codes persistent gespeichert werden.

## Akzeptanz-Kriterien
- [ ] Tabelle \`discount_codes\` mit:
  - [ ] \`id\` (Primary Key)
  - [ ] \`code\` (VARCHAR 50, unique)
  - [ ] \`discount_percentage\` (DECIMAL, 0-100)
  - [ ] \`is_active\` (BOOLEAN, default true)
  - [ ] \`created_at\` (TIMESTAMP)
  - [ ] \`updated_at\` (TIMESTAMP)
  - [ ] \`created_by\` (Foreign Key → users)

- [ ] Tabelle \`code_usage\` mit:
  - [ ] \`id\` (Primary Key)
  - [ ] \`code_id\` (Foreign Key → discount_codes)
  - [ ] \`user_id\` (Foreign Key → users)
  - [ ] \`order_id\` (Foreign Key → orders)
  - [ ] \`discount_amount\` (DECIMAL)
  - [ ] \`used_at\` (TIMESTAMP)

- [ ] Indizes erstellt
- [ ] Migration-Script funktioniert
- [ ] Rollback-Script existiert

## Geschätzter Aufwand
1-2 Stunden

## Abhängigkeiten
Keine
" \
  --label "MVP1,Backend,Database" \
  --project 2

echo -e "${GREEN}✓ US-105 erstellt${NC}"
echo ""

# ============================================================
# TS-102: Code-Validierungs-Logik
# ============================================================
echo -e "${BLUE}Erstelle TS-102...${NC}"
gh issue create \
  --title "TS-102: Code-Validierungs-Logik" \
  --body "# Code-Validierungs-Logik

## Beschreibung
Implementiere die Business-Logik zur Validierung von Codes und Berechnung des Rabatts.

## Akzeptanz-Kriterien
- [ ] Funktion \`validate_code(code: str)\` existiert
- [ ] Prüft: Code existiert + is_active
- [ ] Berechnet: discount_amount = cart_total * discount_percentage / 100
- [ ] Gibt zurück: (valid: bool, discount_amount: float, error: string)
- [ ] Unit Tests: >85% Coverage
- [ ] Edge Cases getestet:
  - [ ] Code null/empty
  - [ ] Code zu lang
  - [ ] Code mit Sonderzeichen
  - [ ] Code case-insensitive?

## Geschätzter Aufwand
2 Stunden

## Abhängigkeiten
- US-105 (Datenbank-Schema muss existieren)
" \
  --label "MVP1,Backend,Logic" \
  --project 2

echo -e "${GREEN}✓ TS-102 erstellt${NC}"
echo ""

# ============================================================
# US-104: Code-Validierungs-API
# ============================================================
echo -e "${BLUE}Erstelle US-104...${NC}"
gh issue create \
  --title "US-104: Code-Validierungs-API" \
  --body "# Code-Validierungs-API

## Als Frontend-Developer / Marketing
Ich möchte eine API zum Validieren von Rabatt-Codes, damit der Checkout Codes prüfen kann.

## Akzeptanz-Kriterien
- [ ] Endpoint \`POST /api/checkout/validate-code\` existiert
- [ ] Request-Payload: \`{ code: string }\`
- [ ] Response bei gültigem Code enthält discount_amount
- [ ] Response bei ungültigem Code enthält Error-Message
- [ ] Code wird überprüft (existiert, is_active)
- [ ] Validierung ist schnell (<100ms)
- [ ] API ist authentifiziert (User-Token erforderlich)

## Technical Details
- Language: Python/Flask
- Database Query: \`discount_codes\` table
- Response time SLA: <100ms

## Geschätzter Aufwand
2-3 Stunden

## Abhängigkeiten
- TS-102 (Validation Logic muss existieren)
- US-105 (Database Schema)
" \
  --label "MVP1,Backend,API" \
  --project 2

echo -e "${GREEN}✓ US-104 erstellt${NC}"
echo ""

# ============================================================
# US-103: Admin-Panel
# ============================================================
echo -e "${BLUE}Erstelle US-103...${NC}"
gh issue create \
  --title "US-103: Code-Verwaltung im Admin-Panel" \
  --body "# Code-Verwaltung im Admin-Panel

## Als Marketing-Manager
Ich möchte neue Rabatt-Codes erstellen und verwalten, damit ich Kampagnen durchführen kann.

## Akzeptanz-Kriterien
- [ ] Admin-Seite für Code-Verwaltung existiert (/admin/codes)
- [ ] Marketing kann neue Codes erstellen mit:
  - [ ] Code-String (alphanumerisch)
  - [ ] Rabatt-Prozentsatz
- [ ] Codes können in Tabelle angezeigt werden
- [ ] Status kann gesehen werden (Aktiv / Inaktiv)
- [ ] Codes können aktiviert/deaktiviert werden
- [ ] Codes können gelöscht werden
- [ ] Erstellungs- und Änderungsdatum werden angezeigt
- [ ] Nur Admins/Marketing können diese Seite sehen

## API Endpoints
- \`POST /api/admin/codes\` — Code erstellen
- \`GET /api/admin/codes\` — Codes auflisten
- \`PATCH /api/admin/codes/{id}\` — Code aktivieren/deaktivieren
- \`DELETE /api/admin/codes/{id}\` — Code löschen

## Geschätzter Aufwand
3-4 Stunden

## Abhängigkeiten
- US-104 (API muss existieren)
- US-105 (Database)
" \
  --label "MVP1,Backend,Admin" \
  --project 2

echo -e "${GREEN}✓ US-103 erstellt${NC}"
echo ""

# ============================================================
# US-101: Code-Eingabe im Checkout
# ============================================================
echo -e "${BLUE}Erstelle US-101...${NC}"
gh issue create \
  --title "US-101: Code-Eingabe im Checkout" \
  --body "# Code-Eingabe im Checkout

## Als Nutzer des Online-Shops
Ich möchte einen Rabatt-Code im Checkout eingeben können, damit ich einen Rabatt auf meine Bestellung erhalte.

## Akzeptanz-Kriterien
- [ ] Input-Feld für Rabatt-Codes im Warenkorb/Checkout vorhanden
- [ ] Feld akzeptiert Text-Eingaben (maximal 50 Zeichen)
- [ ] Button 'Code anwenden' vorhanden
- [ ] Nach Anwenden wird Rabatt sofort berechnet
- [ ] Fehlermeldungen werden angezeigt
- [ ] Design ist responsive (Mobile & Desktop)
- [ ] Code ist optional (Bestellen ohne Code möglich)

## Technical Details
- Component: Checkout/Cart Page
- API: \`POST /api/checkout/validate-code\`
- Payload: \`{ code: string }\`

## Geschätzter Aufwand
2-3 Stunden

## Abhängigkeiten
- US-104 (API muss existieren)
" \
  --label "MVP1,Frontend,Checkout" \
  --project 2

echo -e "${GREEN}✓ US-101 erstellt${NC}"
echo ""

# ============================================================
# US-102: Rabatt-Anzeige
# ============================================================
echo -e "${BLUE}Erstelle US-102...${NC}"
gh issue create \
  --title "US-102: Rabatt-Anzeige" \
  --body "# Rabatt-Anzeige

## Als Nutzer
Ich möchte sehen, wie viel Rabatt ich durch meinen Code erhalte, damit ich die Einsparungen überblicke.

## Akzeptanz-Kriterien
- [ ] Rabatt-Betrag wird angezeigt (z.B. '€ 15,00 Rabatt')
- [ ] Original-Preis und Neu-Preis sind erkennbar
- [ ] Prozentsatz wird angezeigt (z.B. '10% Rabatt')
- [ ] Anzeige wird sofort nach Code-Eintrag aktualisiert
- [ ] Rabatt wird in Bestellzusammenfassung angezeigt
- [ ] Ist visuell deutlich hervorgehoben

## Geschätzter Aufwand
1-2 Stunden

## Abhängigkeiten
- US-101 (Code-Input muss existieren)
" \
  --label "MVP1,Frontend,UX" \
  --project 2

echo -e "${GREEN}✓ US-102 erstellt${NC}"
echo ""

# ============================================================
# TEST-101: Unit Tests
# ============================================================
echo -e "${BLUE}Erstelle TEST-101...${NC}"
gh issue create \
  --title "TEST-101: Unit Tests für Code-Validierung" \
  --body "# Unit Tests für Code-Validierung

## Beschreibung
Schreibe Unit Tests für die Code-Validierungs-Logik.

## Test-Cases
- [ ] Valid code returns discount
- [ ] Invalid code returns error
- [ ] Inactive code returns error
- [ ] Code calculation is correct
- [ ] Empty code returns error
- [ ] Special characters handled
- [ ] Case insensitivity tested

## Coverage Target
>85% Code Coverage

## Geschätzter Aufwand
1-2 Stunden

## Abhängigkeiten
- TS-102 (Validation Logic)
" \
  --label "MVP1,Testing,Backend" \
  --project 2

echo -e "${GREEN}✓ TEST-101 erstellt${NC}"
echo ""

# ============================================================
# TEST-102: Integration Tests
# ============================================================
echo -e "${BLUE}Erstelle TEST-102...${NC}"
gh issue create \
  --title "TEST-102: Integration Tests für Checkout-Flow" \
  --body "# Integration Tests für Checkout-Flow

## Beschreibung
Teste den kompletten Checkout-Flow mit Code-Eingabe.

## Test-Cases
- [ ] User enters valid code → discount applied
- [ ] User enters invalid code → error message
- [ ] User applies code → sees discount in summary
- [ ] User applies code → correct price calculated
- [ ] Code field is optional

## Geschätzter Aufwand
1-2 Stunden

## Abhängigkeiten
- US-101 (Frontend)
- US-104 (API)
" \
  --label "MVP1,Testing,Integration" \
  --project 2

echo -e "${GREEN}✓ TEST-102 erstellt${NC}"
echo ""

# ============================================================
# TEST-103: Manual Testing
# ============================================================
echo -e "${BLUE}Erstelle TEST-103...${NC}"
gh issue create \
  --title "TEST-103: Manual Testing Checklist" \
  --body "# Manual Testing Checklist

## Beschreibung
Manueller Test des kompletten Systems vor Go-Live.

## Code-Generierung (Admin Panel)
- [ ] Neue Codes erstellen
- [ ] Codes aktivieren/deaktivieren
- [ ] Codes anzeigen
- [ ] Codes löschen

## Code-Eingabe (Checkout)
- [ ] Gültigen Code eingeben → Rabatt wird angewendet
- [ ] Ungültigen Code eingeben → Error Message
- [ ] Code löschen und neuen eingeben
- [ ] Abbrechen (mit/ohne Code)

## Mobile & Desktop
- [ ] Responsive Design auf Mobile
- [ ] Input-Feld lesbar
- [ ] Button erreichbar

## Edge Cases
- [ ] Sehr hohe Rabatte (z.B. 99%)
- [ ] Sehr hohe Bestellwerte
- [ ] Mehrere Codes hintereinander

## Geschätzter Aufwand
2-3 Stunden

## Abhängigkeiten
- Alle anderen Stories müssen Done sein
" \
  --label "MVP1,Testing,Manual" \
  --project 2

echo -e "${GREEN}✓ TEST-103 erstellt${NC}"
echo ""

# ============================================================
# Fertig!
# ============================================================
echo "=================================="
echo -e "${GREEN}✅ Alle 10 Issues erfolgreich erstellt!${NC}"
echo ""
echo "Nächste Schritte:"
echo "1. Gehe zu: https://github.com/orgs/tbzdevops/projects/2"
echo "2. Überprüfe dass alle Issues im Projekt sind"
echo "3. Verschiebe sie in die 'Ready for Development' Spalte"
echo "4. Starte die Entwicklung Montag 09:00 Uhr"
echo ""
echo -e "${GREEN}🚀 Viel Erfolg mit MVP1!${NC}"
