FROM node:alpine

WORKDIR /app

COPY package.json package-lock.json /app/

RUN npm install --omit=dev

COPY . .

EXPOSE 3000

CMD ["node" ,"server.js"]





