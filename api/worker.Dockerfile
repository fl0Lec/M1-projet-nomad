FROM python:3.9

COPY . /app
WORKDIR /app
RUN pip install .
ENV CELERY_BROKER_URL="amqp://quizzical-tesla:YmL7jw4zbo3K55P6IjrM@awesome-boyd.internal.100do.se:5672/quizzical-tesla" \
    S3_ENDPOINT_URL="https://s3.100do.se" \
    AWS_ACCESS_KEY_ID="quizzical-tesla" AWS_SECRET_ACCESS_KEY="xAi8SEWXoExqYD1Fk,tO" \
    S3_BUCKET_NAME="quizzical-tesla"
CMD celery --app image_api.worker.app worker