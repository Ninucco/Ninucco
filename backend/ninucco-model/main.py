from dotenv import load_dotenv
import os
from fastapi import FastAPI, UploadFile, Form, File
from fastapi.middleware.cors import CORSMiddleware
import model
import tempfile
from PIL import Image
import uuid
from fastapi.responses import Response

load_dotenv()

MAIN_SERVER_URL = os.environ.get('MAIN_SERVER_URL')
MAIN_SERVER_PORT = os.environ.get('MAIN_SERVER_PORT')

origins = [
    f'{MAIN_SERVER_URL}:{MAIN_SERVER_PORT}'
]

load_dotenv()

MAIN_SERVER_URL = os.environ.get('MAIN_SERVER_URL')
MAIN_SERVER_PORT = os.environ.get('MAIN_SERVER_PORT')

origins = [
    f'{MAIN_SERVER_URL}:{MAIN_SERVER_PORT}'
]

app = FastAPI()
# app.add_middleware(
#     CORSMiddleware,
#     allow_origins = origins
# )
models, classes = model.get_models_and_classes()

@app.post("/predict")
async def predict(modelName: str = Form(...), img: UploadFile = File(...)):
    if modelName in model.model_names and img.filename.lower().endswith('png'):    
        with tempfile.TemporaryDirectory('r+') as tmpdir:
            path = get_image(img, tmpdir)
            print(path)
            resultList = model.predict(path, models[modelName], classes[modelName])
            return {"result_list": resultList}
    else:
        return {"message": "E401"}
        
@app.get("/generate_badge")
async def generate_badge(memberId: str):
    svg = """
    <svg height="170" width="350"
    version="1.1"
    xmlns="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xml:space="preserve">
    <style type="text/css">
        <![CDATA[
            @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=block');
            @keyframes delayFadeIn {
                0%{
                    opacity:0
                }
                60%{
                    opacity:0
                }
                100%{
                    opacity:1
                }
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }
            @keyframes rateBarAnimation {
                0% {
                    stroke-dashoffset: 249.2;
                }
                70% {
                    stroke-dashoffset: 249.2;
                }
                100%{
                    stroke-dashoffset: 35;
                }
            }
            .background {
                fill: url(#grad);
            }
            text {
                fill: white;
                font-family: 'Noto Sans KR', sans-serif;
            }
            text.boj-handle {
                font-weight: 700;
                font-size: 1.45em;
                animation: fadeIn 0.8s ease-in-out forwards;
            }
            text.tier-text {
                font-weight: 700;
                font-size: 1.45em;
                opacity: 55%;
            }
            text.tier-number {
                font-size: 3.1em;
                font-weight: 700;
            }
            .subtitle {
                font-weight: 500;
                font-size: 0.9em;
            }
            .value {
                font-weight: 400;
                font-size: 0.9em;
            }
            .percentage {
                font-weight: 300;
                font-size: 0.8em;
            }
            .progress {
                font-size: 0.7em;
            }
            .item {
                opacity: 0;
                animation: delayFadeIn 1s ease-in-out forwards;
            }
            .rate-bar {
                stroke-dasharray: 249.2;
                stroke-dashoffset: 249.2;
                animation: rateBarAnimation 1.5s forwards ease-in-out;
            }
        ]]>
    </style>
    <defs>
        <linearGradient id="grad" x1="0%" y1="0%" x2="100%" y2="35%">
            <stop offset="10%" style="stop-color:#FFC944;stop-opacity:1"></stop>
            <stop offset="55%" style="stop-color:#FFAF44;stop-opacity:1"></stop>
            <stop offset="100%" style="stop-color:#FF9632;stop-opacity:1"></stop>
        </linearGradient>
    </defs>
    <rect width="350" height="170" rx="10" ry="10" class="background"/>
    <text x="315" y="50" class="tier-text" text-anchor="end" >Gold1</text>
    <text x="35" y="50" class="boj-handle">ccoco</text>
    <g class="item" style="animation-delay: 200ms">
        <text x="35" y="79" class="subtitle">rate</text><text x="145" y="79" class="rate value">1,569</text>
    </g>
    <g class="item" style="animation-delay: 400ms">
        <text x="35" y="99" class="subtitle">solved</text><text x="145" y="99" class="solved value">345</text>
    </g>
    <g class="item" style="animation-delay: 600ms">
        <text x="35" y="119" class="subtitle">class</text><text x="145" y="119" class="class value">4</text>
    </g>
    <g class="rate-bar" style="animation-delay: 800ms">
        <line x1="35" y1="142" x2="249.2" y2="142" stroke-width="4" stroke="floralwhite" stroke-linecap="round"/>
    </g>
    <line x1="35" y1="142" x2="290" y2="142" stroke-width="4" stroke-opacity="40%" stroke="floralwhite" stroke-linecap="round"/>
    <text x="297" y="142" alignment-baseline="middle" class="percentage">84%</text>
    <text x="293" y="157" class="progress" text-anchor="end">1,569 / 1,600</text>
</svg>
    """
    return Response(content=svg, media_type="image/svg+xml")


def get_image(img: UploadFile, dir:str):
    if img.filename.lower().endswith('png'):
        file_name = random_img_filename('png')
        path = f'{dir}\{file_name}'
        with open(path, 'wb') as file_object:
            image = Image.open(img.file)
            image.save(file_object)
    return path

def random_img_filename(file_type:str)->str:
    return f'{uuid.uuid4()}.{file_type}'