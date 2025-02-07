import Express from 'express';
import * as UserController from '../controllers/userController';

const router = Express.Router();

router.get("/api/user", UserController.getUser);

export default router;