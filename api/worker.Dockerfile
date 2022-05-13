FROM python:3.9

COPY . /app
WORKDIR /app
RUN pip install .

CMD celery --app image_api.worker.app worker