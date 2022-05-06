FROM python:3.9

COPY . /app
WORKDIR /app
RUN pip install . \
	&& pip install gunicorn

CMD gunicorn --workers 4 --bind 0.0.0.0:8080 image_api.web:app