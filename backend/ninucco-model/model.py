from dotenv import load_dotenv
import os
# import s3fs
import tensorflow
# from pathlib import Path
import numpy as np

# load .env
load_dotenv()

AWS_ACCESS_KEY = os.environ.get('AWS_ACCESS_KEY')
AWS_SECRET_KEY = os.environ.get('AWS_SECRET_KEY')
BUCKET_NAME = os.environ.get('BUCKET_NAME')

DIR_PATH = os.path.dirname(os.path.realpath(__file__))

# def get_s3fs():
#     return s3fs.S3FileSystem(key=AWS_ACCESS_KEY, secret=AWS_SECRET_KEY)

# def s3_get_keras_model():
#     return tensorflow.keras.models.load_model('keras_model.h5')
def main():
    lables_path = f"{DIR_PATH}/labels.txt"
    lables_file = open(lables_path, encoding='UTF-8')

    classes = []
    line = lables_file.readline()
    while line:
        classes.append(line.split(' ', 1)[1].rstrip())
        line = lables_file.readline()
    lables_file.close()

    model_path = f"{DIR_PATH}/keras_model.h5"
    model = tensorflow.keras.models.load_model(model_path, compile=False)

    image = tensorflow.keras.utils.load_img('10241024.jpg', target_size=(224,224))
    input_arr = tensorflow.keras.utils.img_to_array(image)
    input_arr = np.array([input_arr])
    result = model.predict(input_arr)[0]
    
    for i in range(0,len(result)):
        print(f"{classes[i]}: {result[i]}")
    

if __name__ == '__main__':
    main()