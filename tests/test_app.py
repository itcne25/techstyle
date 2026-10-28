def test_home_page(client):
    """Test that home page loads successfully"""
    rv = client.get("/")
    assert rv.status_code == 200
    assert b"Commit &amp; Chill Hoodie" in rv.data
    assert len(client.get("/api/products").get_json()) == 20
