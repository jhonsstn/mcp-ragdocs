# Use Node.js 22.14 with Debian Bookworm as the base image
FROM node:22.14-bookworm 

# Set the working directory inside the container
WORKDIR /app

# Copy all files from the current directory to the working directory in the container
COPY . /app

# Install project dependencies
RUN npm install

# Build the application
RUN npm run build

# Install Playwright with dependencies
RUN npx -y playwright install --with-deps

# Set the command to run when the container starts
ENTRYPOINT ["node", "build/index.js"]
