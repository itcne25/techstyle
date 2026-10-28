import os
import sys

# Add the project root directory to Python path
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))

import pytest  # noqa: E402
from sqlalchemy import create_engine  # noqa: E402
import database  # noqa: E402
from app import app  # noqa: E402
from seed_data import seed  # noqa: E402


@pytest.fixture
def client(tmp_path, monkeypatch):
    """Exercise actual SQL, with a separate SQLite database for each test."""
    engine = create_engine(f"sqlite:///{(tmp_path / 'shop.db').as_posix()}")
    monkeypatch.setattr(database, "engine", engine)
    monkeypatch.setitem(app.config, "TESTING", True)
    seed(reset=False)
    with app.test_client() as client:
        yield client
    engine.dispose()
