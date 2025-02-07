import Express from 'express';
import * as WeddingController from '../controllers/weddingController';

const router = Express.Router();

router.post("/api/wedding/start-wedding", WeddingController.startWedding);

export default router;