import { Request, Response } from "express";
import { spawn } from "child_process";
import path from "path";

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
    const { latitude, longitude, date } = req.body;

    if (!latitude || !longitude || !date) {
        return res.status(400).json({ error: "Incomplete data" });
    }

    try {
        const prediction = await predictWeather();

        const weather: Weather = {
            latitude: Number(latitude),
            longitude: Number(longitude),
            date: date,
            prediction: {
                minTemperature: prediction.minTemperature,
                maxTemperature: prediction.maxTemperature,
                precipitationProbability: prediction.precipitationProbability,
                condition: prediction.condition || "Unknown"
            }
        };

        res.json(weather);
    } catch (error) {
        console.error("Eroare la predicție:", error);
        res.status(500).json({ error: "Eroare internă." });
    }
};

function predictWeather(): Promise<Prediction> {
    return new Promise((resolve, reject) => {
        const scriptPath = path.join(__dirname, '..', 'ml', 'predict.py');
        const py = spawn('python3', [scriptPath]);

        let data = '';

        py.stdout.on('data', chunk => {
            data += chunk;
        });

        py.stderr.on('data', err => {
            reject(err.toString());
        });

        py.on('close', () => {
            try {
                const result = JSON.parse(data);
                resolve({
                    minTemperature: result.minTemperature,
                    maxTemperature: result.maxTemperature,
                    precipitationProbability: result.precipitationProbability,
                    condition: result.condition
                });
            } catch (e) {
                reject("Eroare la procesarea răspunsului din scriptul Python.");
            }
        });

        py.stdin.write(JSON.stringify({}));
        py.stdin.end();
    });
}