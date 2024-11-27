# You can find your node version with: node --version
FROM node:22.11.0

# Create app directory
WORKDIR /app

# Install app dependencies
COPY package*.json ./

# Install dependecies
RUN npm install
RUN npm install pm2 -g

# Bundle app
COPY . .

# Define your port
EXPOSE 3000

# Tell Docker how to run your app
CMD [ "pm2-runtime", "app.js" ]