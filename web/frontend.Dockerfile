FROM node:current-slim

COPY . /app
WORKDIR /app
RUN npm ci \
	&& npm run build

CMD npm run start