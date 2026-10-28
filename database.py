"""Shared database configuration for the web app and seed command.

SQLite remains available for local development; Compose uses PostgreSQL.
"""
import os
from pathlib import Path
from tempfile import gettempdir

from sqlalchemy import (
    Column, DateTime, Float, Integer, MetaData, String, Table, Text,
    create_engine, func,
)

default_database = Path(gettempdir()) / "techstyle.db"
database_url = os.environ.get("DATABASE_URL", f"sqlite:///{default_database.as_posix()}")
engine = create_engine(database_url, pool_pre_ping=True)
metadata = MetaData()

products = Table(
    "products", metadata,
    Column("id", Integer, primary_key=True),
    Column("name", Text, nullable=False),
    Column("description", Text),
    Column("price", Float, nullable=False),
    Column("category", Text),
    Column("image_url", Text),
    Column("stock", Integer, server_default="100"),
    Column("created_at", DateTime, server_default=func.current_timestamp()),
)
orders = Table(
    "orders", metadata,
    Column("id", Integer, primary_key=True),
    Column("customer_name", Text),
    Column("customer_email", Text),
    Column("customer_address", Text),
    Column("total", Float),
    Column("status", String(30), server_default="pending"),
    Column("created_at", DateTime, server_default=func.current_timestamp()),
)
order_items = Table(
    "order_items", metadata,
    Column("id", Integer, primary_key=True),
    Column("order_id", Integer),
    Column("product_id", Integer),
    Column("quantity", Integer),
    Column("price", Float),
)
users = Table(
    "users", metadata,
    Column("id", Integer, primary_key=True),
    Column("username", Text, unique=True, nullable=False),
    Column("email", Text, unique=True, nullable=False),
    Column("password", Text, nullable=False),
    Column("created_at", DateTime, server_default=func.current_timestamp()),
)


def init_db():
    metadata.create_all(engine)
