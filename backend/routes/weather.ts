import Express from 'express';
import * as WeatherController from '../controllers/weatherController';

const router = Express.Router();

router.post("/api/weather/prediction", WeatherController.getPredictions);

export default router;