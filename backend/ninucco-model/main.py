from fastapi import FastAPI, UploadFile
import model
import tempfile
from pydantic import BaseModel
from PIL import Image
import uuid

model_names = ["animal", "fruit", "highschool", "job"]

app = FastAPI()
models, classes = model.get_models_and_classes()


@app.post("/{model_name}")
async def animal(uploadfile: UploadFile, model_name: str):
    print("hello world!")
    if model_name in model_names and uploadfile.filename.lower().endswith('png'):    
        with tempfile.TemporaryDirectory('r+') as tmpdir:
            path = get_image(uploadfile, tmpdir)
            print(path)
            resultList = model.predict(path, models[model_name], classes[model_name])
            return {"result_list": resultList}
    else:
        return {"message": "E401"}
        
def get_image(uploadfile: UploadFile, dir:str):
    if uploadfile.filename.lower().endswith('png'):
        file_name = random_img_filename('png')
        path = f'{dir}\{file_name}'
        with open(path, 'wb') as file_object:
            image = Image.open(uploadfile.file)
            image.save(file_object)
    return path

def random_img_filename(file_type:str)->str:
    return f'{uuid.uuid4()}.{file_type}'