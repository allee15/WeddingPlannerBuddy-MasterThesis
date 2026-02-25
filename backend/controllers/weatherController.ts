import { Request, Response } from "express";
import axios from "axios";

type Prediction = {
    minTemperature: number;
    maxTemperature: number;
    precipitationProbability: number;
    condition: string;
}

type Weather = {
    latitude: number;
    longitude: number;
    date: string;
    prediction: Prediction;
}

export const getPredictions = async (req: Request, res: Response): Promise<any> => {
    const { latitude, longitude, start_date, end_date } = req.body;

    if (!latitude || !longitude || !start_date) {
        return res.status(400).json({ error: "Incomplete data" });
    }

    try {
        const response = await axios.post("https://wedding-planner-buddy-predictions.vercel.app/", {
            start_date,
            end_date
        }, { 
            timeout: 20000 
        });

        const predictionsArray = Array.isArray(response.data) ? response.data : [response.data];

        const weatherList = predictionsArray.map((predictionData: any) => ({
            latitude: Number(latitude),
            longitude: Number(longitude),
            date: predictionData.date, 
            prediction: {
                minTemperature: predictionData.temp_min || 0,
                maxTemperature: predictionData.temp_max || 0,
                precipitationProbability: predictionData.precipitation || 0,
                condition: predictionData.weather || "Unknown"
            }
        }));

        res.json(weatherList);
    } catch (error) {
        console.error("Eroare la predicție:", error);
        res.status(500).json({ error: "Eroare internă la apelarea serviciului de predicție." });
    }
};