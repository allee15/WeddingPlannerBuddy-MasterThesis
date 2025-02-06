import Express from 'express';
import * as UserController from '../controllers/userController';

const router = Express.Router();

router.post("/api/user", UserController.getUser);

export default router;