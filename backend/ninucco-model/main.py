from fastapi import FastAPI, UploadFile, Form, File
import model
import tempfile
from PIL import Image
import uuid

app = FastAPI()
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