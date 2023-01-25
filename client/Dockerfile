FROM node:13.12.0-alpine
WORKDIR '/app'
COPY package.json .
RUN npm config set registry http://registry.npmjs.org/
RUN npm install
COPY . .
RUN npm run build
CMD ["npm", "start"]