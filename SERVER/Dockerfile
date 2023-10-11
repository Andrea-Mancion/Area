FROM node:latest

COPY package*.json ./

RUN npm install
RUN touch .env

COPY . .

EXPOSE 3000

CMD ["npm", "--max-old-space-size=512", "start"]