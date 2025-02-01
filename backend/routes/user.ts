import Express from 'express';
import path from 'path';
import * as UserController from '../controllers/userController';

const filePathname = "/" + path.basename(__filename, ".ts")
const router = Express.Router();

router.get("/api/user", UserController.addUser);

export default router;