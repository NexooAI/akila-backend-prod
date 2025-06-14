# Use lightweight Node.js image
FROM node:18-slim

# Set the working directory inside the container
WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install --only=production

# Copy all project files to /app
COPY . .

# Expose the port your app listens on (default to 3000 in Express apps)
EXPOSE 3001

# Start the application with index.js
CMD ["node", "index.js"]
