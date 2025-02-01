import express from 'express'
import dotenv from 'dotenv'
import bodyParser from 'body-parser'
import cors from 'cors'

const app = express()
dotenv.config({ path: ".env"})

app.use(cors())
app.use(bodyParser.json())
app.set("trust proxy", true)

app.get("/api", (req, res) => {
    res.send("test")
})

app.listen(8000, () => {
    console.log("Server started at port 8000")
})