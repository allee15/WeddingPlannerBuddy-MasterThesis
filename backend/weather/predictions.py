import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor, RandomForestClassifier
from sklearn.preprocessing import LabelEncoder
from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score, accuracy_score, f1_score, classification_report
import numpy as np

# 1. Încărcare date
train_df = pd.read_csv("vreme_bucuresti.csv")
train_df["date"] = pd.to_datetime(train_df["date"])

# 2. Feature engineering
def prepare_features(df):
    df = df.copy()
    df["day"] = df["date"].dt.day
    df["month"] = df["date"].dt.month
    df["year"] = df["date"].dt.year
    return df

train_df = prepare_features(train_df)

# 3. Pregătire targeturi
weather_encoder = LabelEncoder()
train_df["weather_encoded"] = weather_encoder.fit_transform(train_df["weather"])

X = train_df[["day", "month", "year"]]
y_temp_max = train_df["temp_max"]
y_temp_min = train_df["temp_min"]
y_weather = train_df["weather_encoded"]

# 4. Split train/test
X_train, X_test, y_temp_max_train, y_temp_max_test, y_temp_min_train, y_temp_min_test, y_weather_train, y_weather_test = train_test_split(
    X, y_temp_max, y_temp_min, y_weather, test_size=0.2, random_state=42
)

# 5. Antrenare modele pe setul de train
model_temp_max = RandomForestRegressor(random_state=42)
model_temp_min = RandomForestRegressor(random_state=42)
model_weather = RandomForestClassifier(random_state=42)

model_temp_max.fit(X_train, y_temp_max_train)
model_temp_min.fit(X_train, y_temp_min_train)
model_weather.fit(X_train, y_weather_train)

# 6. Evaluare modele pe setul de test
y_pred_max = model_temp_max.predict(X_test)
y_pred_min = model_temp_min.predict(X_test)
y_pred_weather = model_weather.predict(X_test)

print("=== Temp Max Metrics ===")
print(f"MAE: {mean_absolute_error(y_temp_max_test, y_pred_max):.2f}")
print(f"RMSE: {np.sqrt(mean_squared_error(y_temp_max_test, y_pred_max)):.2f}")
print(f"R² Score: {r2_score(y_temp_max_test, y_pred_max):.2f}")

print("\n=== Temp Min Metrics ===")
print(f"MAE: {mean_absolute_error(y_temp_min_test, y_pred_min):.2f}")
print(f"RMSE: {np.sqrt(mean_squared_error(y_temp_min_test, y_pred_min)):.2f}")
print(f"R² Score: {r2_score(y_temp_min_test, y_pred_min):.2f}")

print("\n=== Weather Classification Metrics ===")
print(f"Accuracy: {accuracy_score(y_weather_test, y_pred_weather):.2f}")
print(f"F1 Score (macro): {f1_score(y_weather_test, y_pred_weather, average='macro'):.2f}")
print("\nClassification Report:")
print(classification_report(y_weather_test, y_pred_weather, target_names=weather_encoder.classes_))

# 7. Funcția de predicție
def predict_weather(start_date_str, end_date_str=None):
    start_date = pd.to_datetime(start_date_str)
    end_date = pd.to_datetime(end_date_str) if end_date_str else start_date

    dates = pd.date_range(start=start_date, end=end_date)
    features = pd.DataFrame({
        "date": dates,
        "day": dates.day,
        "month": dates.month,
        "year": dates.year
    })

    temp_max_preds = model_temp_max.predict(features[["day", "month", "year"]])
    temp_min_preds = model_temp_min.predict(features[["day", "month", "year"]])
    weather_preds = model_weather.predict(features[["day", "month", "year"]])
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

# 8. Exemplu de folosire
if __name__ == "__main__":
    predictions = predict_weather("2024-08-01", "2024-08-07")
    for p in predictions:
        print(p)
