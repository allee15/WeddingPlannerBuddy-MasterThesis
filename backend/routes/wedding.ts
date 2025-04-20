import Express from 'express';
import * as WeddingController from '../controllers/weddingController';
import upload from '../middlewares/upload';

const router = Express.Router();

router.post("/api/wedding/start-wedding", WeddingController.startWedding);
router.get("/api/wedding/get-wedding-details", WeddingController.getWeddingDetails);
router.post("/api/wedding/update-wedding-dress/:id", upload.single("photo"), WeddingController.updateWeddingDress);
router.post("/api/wedding/update-bouquet/:id", upload.single("photo"), WeddingController.updateBouquet);
router.post("/api/wedding/update-groom-suit/:id", upload.single("photo"), WeddingController.updateGroomSuit);
router.post("/api/wedding/update-church-ceremony/:id", WeddingController.updateChurchCeremony);
router.post("/api/wedding/update-party-location/:id", WeddingController.updatePartyLocation);
router.post("/api/wedding/update-civil-marriage/:id", WeddingController.updateCivilMarriage);
router.post("/api/wedding/update-food-menu/:id", WeddingController.updateFoodMenu);
router.post("/api/wedding/update-bar-menu/:id", WeddingController.updateBarMenu);
router.post("/api/wedding/update-wedding-cake/:id", upload.single("photo"), WeddingController.updateWeddingCake);
router.post("/api/wedding/update-live-band/:id", WeddingController.updateLiveBand);
router.post("/api/wedding/edit-wedding-date", WeddingController.updateWeddingDate);
router.post("/api/wedding/add-image", upload.single("photo"), WeddingController.addImageToWedding);

export default router;