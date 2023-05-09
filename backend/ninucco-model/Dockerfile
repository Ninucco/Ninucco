FROM python:3.9
 
WORKDIR /model

COPY . /model

RUN pip install --upgrade pip
RUN pip install tensorflow
RUN pip install tensorflow-estimator
RUN pip install tensorflow-intel
RUN pip install tensorflow-io-gcs-filesystem

RUN pip install --no-cache-dir --upgrade -r /model/requirements.txt

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]