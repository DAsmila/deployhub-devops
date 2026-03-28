from flask import Flask, request, jsonify
from flask_cors import CORS
from pymongo import MongoClient
from datetime import datetime
import os

app = Flask(__name__)
CORS(app)

MONGO_URI = os.environ.get("MONGO_URI", "mongodb://mongo:27017/taskdb")
client = MongoClient(MONGO_URI)
db = client["taskdb"]
tasks_col = db["tasks"]

@app.route("/health", methods=["GET"])
def health():
    return jsonify({"status": "OK", "timestamp": str(datetime.utcnow())}), 200

@app.route("/data", methods=["GET"])
def get_tasks():
    tasks = list(tasks_col.find({}, {"_id": 0}))
    return jsonify(tasks), 200

@app.route("/data", methods=["POST"])
def add_task():
    body = request.get_json()
    if not body or "task" not in body:
        return jsonify({"error": "task field required"}), 400
    doc = {
        "task": body["task"],
        "status": body.get("status", "pending"),
        "created_at": str(datetime.utcnow())
    }
    tasks_col.insert_one(doc)
    return jsonify({"message": "Task added successfully"}), 201

@app.route("/data/<task_name>", methods=["DELETE"])
def delete_task(task_name):
    result = tasks_col.delete_one({"task": task_name})
    if result.deleted_count == 0:
        return jsonify({"error": "Task not found"}), 404
    return jsonify({"message": "Task deleted"}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=False)
