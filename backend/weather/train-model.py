import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor, RandomForestClassifier
from sklearn.preprocessing import LabelEncoder
from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score, accuracy_score, f1_score, classification_report
import numpy as np
import joblib

# 1. Load data
train_df = pd.read_csv("vreme_bucuresti.csv")
train_df["date"] = pd.to_datetime(train_df["date"])

# 2. Feature engineering
def prepare_features(df):
    df = df.copy()
    df["day"] = df["date"].dt.day
    df["month"] = df["date"].dt.month
    df["year"] = df["date"].dt.year
    df["precipitation"] = df["precipitation"].fillna(0)
    return df

train_df = prepare_features(train_df)

# 3. Target preparing
weather_encoder = LabelEncoder()
train_df["weather_encoded"] = weather_encoder.fit_transform(train_df["weather"])

X = train_df[["day", "month", "year", "precipitation"]]
y_temp_max = train_df["temp_max"]
y_temp_min = train_df["temp_min"]
y_weather = train_df["weather_encoded"]
y_precip = train_df["precipitation"]

# 4. Split train/test
X_train, X_test, y_temp_max_train, y_temp_max_test, y_temp_min_train, y_temp_min_test, y_weather_train, y_weather_test, y_precip_train, y_precip_test = train_test_split(
    X, y_temp_max, y_temp_min, y_weather, y_precip, test_size=0.2, random_state=42
)

# 5. Antrenare modele pe setul de train
model_temp_max = RandomForestRegressor(random_state=42)
model_temp_min = RandomForestRegressor(random_state=42)
model_weather = RandomForestClassifier(random_state=42)
model_precip = RandomForestRegressor(random_state=42)

model_temp_max.fit(X_train, y_temp_max_train)
model_temp_min.fit(X_train, y_temp_min_train)
model_weather.fit(X_train, y_weather_train)
model_precip.fit(X_train[["day", "month", "year"]], y_precip_train)

# 6. Evaluate models
y_pred_max = model_temp_max.predict(X_test)
y_pred_min = model_temp_min.predict(X_test)
y_pred_weather = model_weather.predict(X_test)
y_pred_precip = model_precip.predict(X_test[["day", "month", "year"]])

print("\n=== Temp Max Metrics ===")
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
print(classification_report(y_weather_test, y_pred_weather))

print("\n=== Precipitation Metrics ===")
print(f"MAE: {mean_absolute_error(y_precip_test, y_pred_precip):.2f}")
print(f"RMSE: {np.sqrt(mean_squared_error(y_precip_test, y_pred_precip)):.2f}")
print(f"R² Score: {r2_score(y_precip_test, y_pred_precip):.2f}")

# 7. save models
joblib.dump(model_temp_max, "model_temp_max.pkl")
joblib.dump(model_temp_min, "model_temp_min.pkl")
joblib.dump(model_weather, "model_weather.pkl")
joblib.dump(model_precip, "model_precip.pkl")
joblib.dump(weather_encoder, "weather_encoder.pkl")

print("Models successfully saved")