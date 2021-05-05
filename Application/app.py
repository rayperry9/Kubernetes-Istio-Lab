from flask import Flask, render_template, request, url_for, jsonify
from flask_cors import CORS
from pymongo import MongoClient
from bp_calculator import get_input, get_results
import time
import json
from bson import json_util

app = Flask(__name__)
CORS(app)

cluster = MongoClient('mongodb://root:secretpassword@bpcalculator-mongodb:27017/admin?authSource=admin&compressors=disabled&gssapiServiceName=mongodb')
db = cluster["bpcalculatordb"]
collection = db["bpdata"]

@app.route("/api", methods=["POST"])
def store():
    if request.method == "POST":
        print(request.json)

        named_tuple = time.localtime()
        time_string = time.strftime("%m/%d/%Y, %H:%M:%S", named_tuple)

        email = request.json["email"]
        systolic_value = request.json["systolic_value"]
        diastolic_value = request.json["diastolic_value"]

        bprisk = get_input(systolic_value, diastolic_value)

        post = {
            "Timestamp": time_string,
            "Email": email,
            "Systolic Value": systolic_value,
            "Diastolic Value": diastolic_value,
            "Blood Pressure": bprisk
        }
        collection.insert_one(post)


        return json.loads(json_util.dumps(post))

@app.route("/api", methods=["GET"])
def get_all():
    email = request.args.get('email')
    history = collection.find({"Email": email}, {"_id": 0})
    list_cursor = list(history)

    # return str(list_cursor)
    return jsonify(list_cursor)

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)