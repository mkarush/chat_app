from flask import Flask, jsonify, request
from pymongo import MongoClient
from passlib.hash import sha256_crypt

app = Flask(__name__)

client = MongoClient('127.0.0.1', 27017)
db = client.user_system


@app.route('/login', methods=['POST'])
def query_record():
    if request.method == "POST":
        username = request.form["username"]
        password = request.form["password"]

        login_check = db.users.find_one({"username": username})

        if login_check is None:
            message = "username-doesn't-exist"
            return jsonify([message])
        elif login_check is not None:
            authenticated = sha256_crypt.verify(password, login_check['password'])
            if authenticated:
                message = "success"
                return jsonify([message])
            else:
                message = "wrong-password"
                return jsonify([message])
        else:
            message = "success"
            return jsonify([message])
    else:
        message = "RestApiError"
        return jsonify([message])


@app.route('/register', methods=['POST'])
def create_record():
    if request.method == "POST":
        username = request.form["username"]
        password = request.form["password"]

        password_encrypt = sha256_crypt.encrypt(password)

        login_check = db.users.find_one({"username": username})

        if login_check is None:
            data = {'username': username, 'password': password_encrypt}
            db.users.insert_one(data)

            message = "success"
            return jsonify([message])
        else:
            message = "user-exist"
            return jsonify([message])
    else:
        message = "RestApiError"
        return jsonify([message])


@app.route('/users', methods=['GET'])
def send_record():
    if request.method == "GET":
        values = db.users.find({}, {"_id": 0, "password": 0})
        return jsonify(list(values))
    else:
        message = "RestApiError"
        return jsonify([message])


@app.route('/messaging', methods=['GET', 'POST'])
def send_data():
    if request.method == "GET":
        args = request.args["tag"]
        values = db.chat_box.find({"tag": args}, {"_id": 0, "tag": 1, "data": 1, "username": 1})
        return jsonify(list(values))
    elif request.method == "POST":
        db.chat_box.insert_one(
            {"tag": request.form["tag"], "data": request.form["data"], "username": request.form["username"]})
        message = "success"
        return jsonify([message])
    else:
        message = "RestApiError"
        return jsonify([message])
