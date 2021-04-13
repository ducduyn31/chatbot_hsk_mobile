FROM node:15.8.0

WORKDIR /app

COPY /build/web /app/web
COPY /key_techqila /app/ssl
COPY server.js /app
COPY package.json /app

RUN npm config set unsafe-perm true
RUN npm install


CMD ["npm", "start"]