#!/bin/bash
# run_dev.sh — Set up the local dev environment and start TechStyle.
#
# Usage: ./run_dev.sh
#
# On first run:  creates .venv, installs dependencies, seeds the DB.
# On later runs: reuses the existing .venv and preserves existing products in the configured database.

set -e

VENV_DIR=".venv"

# ── 1. Create virtual environment if it doesn't exist ──────────────
if [ ! -d "$VENV_DIR" ]; then
  echo "--> Creating virtual environment..."
  python3 -m venv "$VENV_DIR"
fi

# ── 2. Activate venv ───────────────────────────────────────────────
source "$VENV_DIR/bin/activate"

# ── 3. Install / update dependencies ──────────────────────────────
echo "--> Installing dependencies..."
pip install --quiet --upgrade pip
pip install --quiet -r requirements.txt

# Initialise the configured backend without resetting products.
python seed_data.py --if-empty

# ── 5. Start the development server ───────────────────────────────
echo ""
echo "==> Starting TechStyle dev server at http://localhost:5001"
echo "    Press Ctrl+C to stop."
echo ""
python app.py
