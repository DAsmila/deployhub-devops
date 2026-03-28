import pytest
import json
from unittest.mock import patch, MagicMock
import sys
import os
sys.path.insert(0, os.path.dirname(__file__))

# Mock pymongo before importing app
with patch("pymongo.MongoClient") as mock_client:
    mock_db = MagicMock()
    mock_client.return_value.__getitem__.return_value = mock_db
    mock_db.__getitem__.return_value = MagicMock()
    from app import app

@pytest.fixture
def client():
    app.config["TESTING"] = True
    with app.test_client() as c:
        yield c

def test_health(client):
    res = client.get("/health")
    assert res.status_code == 200
    data = json.loads(res.data)
    assert data["status"] == "OK"

def test_add_task_missing_field(client):
    res = client.post("/data", json={}, content_type="application/json")
    assert res.status_code == 400

def test_get_tasks(client):
    with patch("app.tasks_col") as mock_col:
        mock_col.find.return_value = [{"task": "test", "status": "pending", "created_at": "2024-01-01"}]
        res = client.get("/data")
        assert res.status_code == 200
