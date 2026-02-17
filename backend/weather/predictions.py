import pandas as pd
import numpy as np
import joblib
import os

MODEL_DIR = os.path.dirname(__file__)

model_temp_max = joblib.load(os.path.join(MODEL_DIR, "model_temp_max.pkl"))
model_temp_min = joblib.load(os.path.join(MODEL_DIR, "model_temp_min.pkl"))
model_weather = joblib.load(os.path.join(MODEL_DIR, "model_weather.pkl"))
model_precip = joblib.load(os.path.join(MODEL_DIR, "model_precip.pkl"))
weather_encoder = joblib.load(os.path.join(MODEL_DIR, "weather_encoder.pkl"))

def predict_weather(start_date_str, end_date_str=None):
    start_date = pd.to_datetime(start_date_str)
    end_date = pd.to_datetime(end_date_str) if end_date_str else start_date

    dates = pd.date_range(start=start_date, end=end_date, inclusive="both")
    features = pd.DataFrame({
        "date": dates,
        "day": dates.day,
        "month": dates.month,
        "year": dates.year,
        "precipitation": 0
    })

    precip_preds = model_precip.predict(features[["day", "month", "year"]])
    features["precipitation"] = precip_preds 

    temp_max_preds = model_temp_max.predict(features[["day", "month", "year", "precipitation"]])
    temp_min_preds = model_temp_min.predict(features[["day", "month", "year", "precipitation"]])
    weather_preds = model_weather.predict(features[["day", "month", "year", "precipitation"]])
    weather_labels = weather_encoder.inverse_transform(weather_preds)

    results = []
    for i in range(len(dates)):
        results.append({
            "date": dates[i].strftime("%Y-%m-%d"),
            "temp_max": round(temp_max_preds[i], 1),
            "temp_min": round(temp_min_preds[i], 1),
            "weather": weather_labels[i],
            "precipitation": round(precip_preds[i], 1)
        })
    return results
