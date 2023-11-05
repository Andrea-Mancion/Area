FROM node:latest

COPY package*.json ./

RUN npm install
RUN touch .env

COPY . .

EXPOSE 8080
ENV NODE_OPTIONS=--max-old-space-size=8192
CMD ["npm", "--max-old-space-size=512", "start"]
