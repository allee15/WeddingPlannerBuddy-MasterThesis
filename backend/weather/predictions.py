import pandas as pd
from sklearn.ensemble import RandomForestRegressor, RandomForestClassifier
from sklearn.preprocessing import LabelEncoder

# 1. Încărcare date
train_df = pd.read_csv("train_set.csv")
train_df["date"] = pd.to_datetime(train_df["date"])

# 2. Feature engineering
def prepare_features(df):
    df = df.copy()
    df["day"] = df["date"].dt.day
    df["month"] = df["date"].dt.month
    df["year"] = df["date"].dt.year
    df["day_of_week"] = df["date"].dt.dayofweek
    return df

train_df = prepare_features(train_df)

# 3. Pregătire targeturi
weather_encoder = LabelEncoder()
train_df["weather_encoded"] = weather_encoder.fit_transform(train_df["weather"])

X_train = train_df[["day", "month", "day_of_week"]]
y_temp_max = train_df["temp_max"]
y_temp_min = train_df["temp_min"]
y_weather = train_df["weather_encoded"]

# 4. Antrenare modele
model_temp_max = RandomForestRegressor(random_state=42)
model_temp_min = RandomForestRegressor(random_state=42)
model_weather = RandomForestClassifier(random_state=42)

model_temp_max.fit(X_train, y_temp_max)
model_temp_min.fit(X_train, y_temp_min)
model_weather.fit(X_train, y_weather)

# 5. Funcția de predicție
def predict_weather(start_date_str, end_date_str=None):
    start_date = pd.to_datetime(start_date_str)
    end_date = pd.to_datetime(end_date_str) if end_date_str else start_date

    dates = pd.date_range(start=start_date, end=end_date)
    features = pd.DataFrame({
        "date": dates,
        "day": dates.day,
        "month": dates.month,
        "day_of_week": dates.dayofweek
    })

    temp_max_preds = model_temp_max.predict(features[["day", "month", "day_of_week"]])
    temp_min_preds = model_temp_min.predict(features[["day", "month", "day_of_week"]])
    weather_preds = model_weather.predict(features[["day", "month", "day_of_week"]])
    weather_labels = weather_encoder.inverse_transform(weather_preds)

    results = []
    for i in range(len(dates)):
        results.append({
            "date": dates[i].strftime("%Y-%m-%d"),
            "temp_max": round(temp_max_preds[i], 1),
            "temp_min": round(temp_min_preds[i], 1),
            "weather": weather_labels[i]
        })
    return results

# 6. Exemplu de folosire
if __name__ == "__main__":
    predictions = predict_weather("2024-08-01", "2024-08-07")
    for p in predictions:
        print(p)
