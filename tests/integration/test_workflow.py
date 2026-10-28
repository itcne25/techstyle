def test_user_registration_flow(client):
    """Test complete user registration workflow"""
    # Test registration with missing fields returns 200
    rv = client.post("/register")
    assert rv.status_code == 200

    # Test registration form submission with full data
    rv = client.post(
        "/register",
        data={
            "username": "testuser",
            "email": "test@example.com",
            "password": "testpassword",
        },
    )
    assert rv.status_code == 302
    login = client.post("/login", data={"username": "testuser", "password": "testpassword"})
    assert login.status_code == 302
    duplicate = client.post("/register", data={
        "username": "testuser", "email": "test@example.com", "password": "another",
    })
    assert duplicate.status_code == 200
    assert b"already taken" in duplicate.data
