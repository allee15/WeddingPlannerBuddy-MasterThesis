import express from 'express'
import dotenv from 'dotenv'
import bodyParser from 'body-parser'
import cors from 'cors'
import path from 'path';

dotenv.config({ path: path.resolve(__dirname, '.env') });

import userRoutes from './routes/user';
import weddingRoutes from './routes/wedding';
import tableRoutes from './routes/table';
import weatherRoutes from './routes/weather';
import { createDatabaseConnection } from './configs/db';
import * as admin from "firebase-admin";
import firebaseCertificate from './configs/firebase-admin';

const app = express()

admin.initializeApp({
  credential: admin.credential.cert(firebaseCertificate as admin.ServiceAccount),
  databaseURL: "https://weddingplannerbuddy.firebaseio.com"
});

app.use(cors())
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));
app.set("trust proxy", true);

app.use(userRoutes);
app.use(weddingRoutes);
app.use(tableRoutes);
app.use(weatherRoutes);
app.use('/uploads', express.static('uploads'));

createDatabaseConnection().then(() => {
    app.listen(8000, () => {
        console.log("Server started at port 8000")
    })
})