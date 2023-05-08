from fastapi import FastAPI, UploadFile
import model
import tempfile
from PIL import Image
import uuid

app = FastAPI()
models, classes = model.get_models_and_classes()


@app.post("/predict/{model_name}")
async def predict(uploadfile: UploadFile, model_name: str):
    print(model_name)
    if model_name in model.model_names and uploadfile.filename.lower().endswith('png'):    
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