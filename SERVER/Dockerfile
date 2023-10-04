FROM node:15-alpine

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "--max-old-space-size=512", "start"]