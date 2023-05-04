from dotenv import load_dotenv
import os
import s3fs
import tensorflow
# from pathlib import Path
import numpy as np
import tempfile

# load .env
load_dotenv()

AWS_ACCESS_KEY = os.environ.get('AWS_ACCESS_KEY')
AWS_SECRET_KEY = os.environ.get('AWS_SECRET_KEY')
BUCKET_NAME = os.environ.get('BUCKET_NAME')

DIR_PATH = os.path.dirname(os.path.realpath(__file__))

model = []
classes = []

def get_s3fs():
    return s3fs.S3FileSystem(key=AWS_ACCESS_KEY, secret=AWS_SECRET_KEY)

def s3_set_keras_model_and_classes(model_type: str):
    global model
    global classes

    with tempfile.TemporaryDirectory() as tempdir:
        s3fs = get_s3fs()
        s3fs.get(f"{BUCKET_NAME}/model/{model_type}/", f"{tempdir}/model/{model_type}/", recursive=True)
        model = tensorflow.keras.models.load_model(f"{tempdir}/model/{model_type}/keras_model.h5", compile=False)

        lables_path = f"{tempdir}/model/{model_type}/labels.txt"
        lables_file = open(lables_path, encoding='UTF-8')

        classes = []
        line = lables_file.readline()
        while line:
            classes.append(line.split(' ', 1)[1].rstrip())
            line = lables_file.readline()
        lables_file.close()
def main():
    global model
    global classes

    s3_set_keras_model_and_classes("animal")

    image = tensorflow.keras.utils.load_img('10241024.jpg', target_size=(224,224))
    input_arr = tensorflow.keras.utils.img_to_array(image)
    input_arr = np.array([input_arr])
    result = model.predict(input_arr)[0]
    
    for i in range(0,len(result)):
        print(f"{classes[i]}: {result[i]}")
    

if __name__ == '__main__':
    main()