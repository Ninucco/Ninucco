from fastapi import FastAPI, File
from tensorflow import keras
import model
from pydantic import BaseModel


app = FastAPI()
model.get_model()

class ClassificationTool:
    model: list
    classes: list

types = ["animal", "", "", "", ""]
tools = {}

class SimilarityRes(BaseModel):
    keyword: str
    value: float

@app.post("/")
async def animal(file: bytes = File()):
    resultList = model.animal_model.predict(file)
    return {"resultList": resultList}