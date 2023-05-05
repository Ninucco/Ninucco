from dotenv import load_dotenv
import os
import s3fs
import tensorflow
import numpy as np
import tempfile

# load .env
load_dotenv()

AWS_ACCESS_KEY = os.environ.get('AWS_ACCESS_KEY')
AWS_SECRET_KEY = os.environ.get('AWS_SECRET_KEY')
BUCKET_NAME = os.environ.get('BUCKET_NAME')

DIR_PATH = os.path.dirname(os.path.realpath(__file__))

model_names = ["animal", "fruit", "highschool", "job"]


def get_s3fs():
    return s3fs.S3FileSystem(key=AWS_ACCESS_KEY, secret=AWS_SECRET_KEY)


def get_models_and_classes():
    global model_names
    models = {}
    classes = {}

    with tempfile.TemporaryDirectory() as tempdir:
        s3fs = get_s3fs()
        s3fs.get(f"{BUCKET_NAME}/model/",
                 f"{tempdir}/model/", recursive=True)
        for model_name in model_names:
            models[model_name] = tensorflow.keras.models.load_model(
                f"{tempdir}/model/{model_name}/keras_model.h5", compile=False)

            classes[model_name] = []
            lables_path = f"{tempdir}/model/{model_name}/labels.txt"
            lables_file = open(lables_path, encoding='UTF-8')

            line = lables_file.readline()
            while line:
                classes[model_name].append(line.split(' ', 1)[1].rstrip())
                line = lables_file.readline()
            lables_file.close()
        print(models.keys())
        return models, classes


def predict(img_dir, _model, _class):
    image = tensorflow.keras.utils.load_img(
        img_dir, target_size=(224, 224))
    input_arr = tensorflow.keras.utils.img_to_array(image)
    input_arr = np.array([input_arr])

    result = _model.predict(input_arr)[0]

    similarity_result = {}
    for i in range(0, len(result)):
        similarity_result[_class[i]] = result[i]
    similarity_result = {k: v for k, v in sorted(
        similarity_result.items(), key=lambda item: item[1], reverse=True)}
    return similarity_result


def main():
    models = {}
    classes = {}

    models, classes = get_models_and_classes()
    similarity_result = predict(
        '10241024.png', models['job'], classes['job'])
    print(similarity_result)


if __name__ == '__main__':
    main()
