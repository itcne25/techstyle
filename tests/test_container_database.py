from sqlalchemy import select, text
from sqlalchemy.exc import OperationalError
from datetime import datetime

import database
from seed_data import seed


def test_checkout_with_quoted_customer_name(client):
    product = client.get("/api/products").get_json()[0]
    client.post(f"/cart/add/{product['id']}", data={"quantity": "2"})
    response = client.post("/checkout", data={
        "name": "Sam O'Connor", "email": "sam@example.test", "address": "Testweg 1",
    }, follow_redirects=True)
    assert response.status_code == 200
    with database.engine.connect() as db:
        order = db.execute(select(database.orders)).mappings().one()
        item = db.execute(select(database.order_items)).mappings().one()
    assert order["customer_name"] == "Sam O'Connor"
    assert order["total"] == product["price"] * 2
    assert item["order_id"] == order["id"]
    assert item["quantity"] == 2


def test_admin_accepts_database_datetime_values(client, monkeypatch):
    """PostgreSQL returns datetime objects where raw SQLite returns strings."""
    from app import query_db

    client.post("/register", data={
        "username": "sam", "email": "sam@example.test", "password": "exercise",
    })
    client.post("/cart/add/1", data={"quantity": "1"})
    client.post("/checkout", data={
        "name": "Sam", "email": "sam@example.test", "address": "Testweg 1",
    })

    def timestamp_rows(query, args=None, one=False):
        result = query_db(query, args, one)
        if not one:
            result = [dict(row) for row in result]
            for row in result:
                if isinstance(row.get("created_at"), str):
                    row["created_at"] = datetime.fromisoformat(row["created_at"])
        return result

    monkeypatch.setattr("app.query_db", timestamp_rows)
    assert client.get("/admin").status_code == 200


def test_seed_on_restart_preserves_changes(client):
    with database.engine.begin() as db:
        db.execute(text("UPDATE products SET stock = 7 WHERE id = 1"))
    seed(reset=False)
    with database.engine.connect() as db:
        assert db.execute(text("SELECT stock FROM products WHERE id = 1")).scalar_one() == 7
        assert db.execute(text("SELECT COUNT(*) FROM products")).scalar_one() == 20


def test_search_treats_input_as_data(client):
    response = client.get("/", query_string={"search": "' OR 1=1 --"})
    assert response.status_code == 200
    assert b"Commit &amp; Chill Hoodie" not in response.data


def test_health_checks_actual_database(client, monkeypatch):
    assert client.get("/healthz").get_json() == {"status": "ok"}

    def unavailable(*args, **kwargs):
        raise OperationalError("SELECT", {}, Exception("database unavailable"))

    monkeypatch.setattr("app.query_db", unavailable)
    response = client.get("/healthz")
    assert response.status_code == 503
    assert response.get_json() == {"status": "unavailable"}
