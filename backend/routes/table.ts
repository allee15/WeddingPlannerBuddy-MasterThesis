import Express from 'express';
import * as TableController from '../controllers/tableController';

const router = Express.Router();

router.post("/api/table/add-table", TableController.addTable);
router.post("/api/table/add-rectangle", TableController.addRectangle);
router.post("/api/table/add-guest", TableController.addParticipant);

export default router;