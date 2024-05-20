from flask import Flask, jsonify
from pymongo import MongoClient

app = Flask(__name__)

# MongoDB connection
mongo_client = MongoClient("mongodb://mongo:27017/")
db = mongo_client["mydatabase"]
collection = db["my_collection"]

@app.route('/')
def hello():
    # Access MongoDB
    mongo_data = collection.find_one()

    return jsonify({"mongo_data": mongo_data})

@app.route('/add_data')
def add_data():
    # Add data to MongoDB
    data_to_insert = {"name": "John Doe", "age": 30}
    inserted_data = collection.insert_one(data_to_insert)

    return jsonify({"message": "Data added successfully", "inserted_id": str(inserted_data.inserted_id)})

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=3000)
