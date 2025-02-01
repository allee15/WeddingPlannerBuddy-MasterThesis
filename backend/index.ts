import express from 'express'
import dotenv from 'dotenv'
import bodyParser from 'body-parser'
import cors from 'cors'

import userRoutes from './routes/user';
import { createDatabaseConnection } from './configs/db';

const app = express()
dotenv.config({ path: "./.env"})

app.use(cors())
app.use(bodyParser.json())
app.set("trust proxy", true)

app.use(userRoutes);

createDatabaseConnection().then(() => {
    app.listen(8000, () => {
        console.log("Server started at port 8000")
    })
})