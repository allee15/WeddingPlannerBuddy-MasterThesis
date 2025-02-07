import express from 'express'
import dotenv from 'dotenv'
import bodyParser from 'body-parser'
import cors from 'cors'

import userRoutes from './routes/user';
import weddingRoutes from './routes/wedding';
import { createDatabaseConnection } from './configs/db';
import * as admin from "firebase-admin";

const firebaseCertificate = require("./weddingplannerbuddy-firebase-adminsdk-bajjl-5027c2ca42.json");

const app = express()
dotenv.config({ path: "./.env"})

admin.initializeApp({
  credential: admin.credential.cert(firebaseCertificate),
  databaseURL: "https://weddingplannerbuddy.firebaseio.com"
});

app.use(cors())
app.use(bodyParser.json())
app.set("trust proxy", true)

app.use(userRoutes);
app.use(weddingRoutes);

createDatabaseConnection().then(() => {
    app.listen(8000, () => {
        console.log("Server started at port 8000")
    })
})