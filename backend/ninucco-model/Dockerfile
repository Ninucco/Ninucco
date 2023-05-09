FROM python:3.9
 
WORKDIR /model

COPY . /model

RUN python --version
RUN pip install --upgrade pip
RUN pip install tensorflow==2.12.0
RUN pip install tensorflow-estimator==2.12.0
RUN pip install tensorflow-intel==2.12.0
RUN pip install tensorflow-io-gcs-filesystem==0.31.0

RUN pip install --no-cache-dir --upgrade -r /model/requirements.txt

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]