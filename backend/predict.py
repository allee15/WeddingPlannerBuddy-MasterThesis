import json
from weather.predictions import predict_weather

def main(request):
    try:
        body = request.json()
        start_date = body.get("start_date")
        end_date = body.get("end_date")

        if not start_date:
            return {
                "status": 400,
                "body": {"error": "Missing start_date"}
            }

        predictions = predict_weather(start_date, end_date)

        return {
            "status": 200,
            "body": predictions
        }

    except Exception as e:
        return {
            "status": 500,
            "body": {"error": str(e)}
        }
