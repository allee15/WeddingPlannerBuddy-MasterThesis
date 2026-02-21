from flask import Flask

app = Flask(__name__)

@app.get('/')
async def index():
    return {"status": "ok"}