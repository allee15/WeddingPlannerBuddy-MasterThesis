from flask import Flask, request, jsonify
from predictions import predict_weather 

app = Flask(__name__)

@app.route("/predict", methods=["POST"])
def predict():
    data = request.get_json()
    start_date = data.get("start_date")
    end_date = data.get("end_date")

    if not start_date:
        return jsonify({"error": "Missing start_date"}), 400

    try:
        predictions = predict_weather(start_date, end_date)
        return jsonify(predictions)
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(port=5001, debug=True)
