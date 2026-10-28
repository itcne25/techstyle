"""Check the real Compose stack, checkout and persistence using only stdlib.

Requires a running stack on WEB_PORT. Recreates both containers, preserving volumes.
Run against a disposable exercise stack, never against an existing customer database.
"""
import http.cookiejar
import json
import os
import subprocess
import urllib.parse
import urllib.request
import uuid


def main():
    base = f"http://127.0.0.1:{os.environ.get('WEB_PORT', '5001')}"
    opener = urllib.request.build_opener(
        urllib.request.HTTPCookieProcessor(http.cookiejar.CookieJar())
    )

    def request(path, data=None):
        body = None if data is None else urllib.parse.urlencode(data).encode()
        with opener.open(base + path, data=body, timeout=10) as response:
            return response.read()

    assert json.loads(request("/healthz"))["status"] == "ok"
    products = json.loads(request("/api/products"))
    assert len(products) >= 20
    request(f"/cart/add/{products[0]['id']}", {"quantity": "2"})
    assert json.loads(request("/api/cart/count"))["count"] == 2
    confirmation = request("/checkout", {
        "name": "Sam O'Connor", "email": "sam@example.test", "address": "Testweg 1",
    })
    assert b"Order Confirmed" in confirmation

    # A unique product proves writes and persistence across BOTH container replacements.
    marker = "Persistence-" + uuid.uuid4().hex
    request("/admin/products/add", {
        "name": marker, "description": "Container acceptance test",
        "price": "12.50", "category": "Tests", "stock": "7", "image_url": "",
    })
    command = ["docker", "compose", "--env-file", ".env.container"]
    subprocess.run(command + ["down"], check=True)
    subprocess.run(command + ["up", "-d", "--wait", "--wait-timeout", "120"], check=True)
    persisted = json.loads(request("/api/products"))
    product = next(p for p in persisted if p["name"] == marker)
    assert product["stock"] == 7
    request(f"/admin/products/delete/{product['id']}", {})
    print("PASS: health, catalogue, cart, checkout, DB writes, persistence after recreation")


if __name__ == "__main__":
    main()
