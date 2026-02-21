import json
from weather.predictions import predict_weather

def handler(request, context=None):
    try:
        body = json.loads(request.body)
        start_date = body.get("start_date")
        end_date = body.get("end_date")

        if not start_date:
            return {
                "statusCode": 400,
                "body": json.dumps({"error": "Missing start_date"})
            }

        predictions = predict_weather(start_date, end_date)
        return {
            "statusCode": 200,
            "body": json.dumps(predictions)
        }

    except Exception as e:
        import traceback
        traceback.print_exc()
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }
