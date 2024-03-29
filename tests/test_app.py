def test_health(client):
    response = client.get("/health")
    assert response.status_code == 200
    assert response.data == b"System running"


def test_hello_world(client):
    response = client.get("/")
    assert response.status_code == 200
    assert response.data == b"Hello World!"
