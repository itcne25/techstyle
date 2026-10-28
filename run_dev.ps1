# run_dev.ps1 — Set up the local dev environment and start TechStyle (Windows).
#
# Usage: powershell -ExecutionPolicy Bypass -File .\run_dev.ps1
#
# On first run:  creates .venv, installs dependencies, seeds the DB.
# On later runs: reuses the existing .venv and preserves existing products in the configured database.

$ErrorActionPreference = "Stop"

$VenvDir = ".venv"

# -- 1. Create virtual environment if it doesn't exist ----------------
if (-not (Test-Path $VenvDir)) {
  # Prefer the py launcher: on Windows a bare "python" is often the Microsoft
  # Store stub, which does nothing useful.
  if (Get-Command py -ErrorAction SilentlyContinue) {
    $PyExe = "py"; $PyArgs = @("-3")
  } elseif (Get-Command python -ErrorAction SilentlyContinue) {
    $PyExe = "python"; $PyArgs = @()
  } else {
    Write-Host "ERROR: Python not found. Install it from https://www.python.org/downloads/"
    Write-Host "       and tick 'Add python.exe to PATH' during setup."
    exit 1
  }

  Write-Host "--> Creating virtual environment..."
  & $PyExe @PyArgs -m venv $VenvDir
}

# -- 2. Activate venv -------------------------------------------------
& (Join-Path $VenvDir "Scripts\Activate.ps1")

# -- 3. Install / update dependencies ---------------------------------
Write-Host "--> Installing dependencies..."
python -m pip install --quiet --upgrade pip
python -m pip install --quiet -r requirements.txt

# -- 4. Initialise the configured backend without resetting products ---
python seed_data.py --if-empty
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

# -- 5. Start the development server ----------------------------------
Write-Host ""
Write-Host "==> Starting TechStyle dev server at http://localhost:5001"
Write-Host "    Press Ctrl+C to stop."
Write-Host ""
python app.py
