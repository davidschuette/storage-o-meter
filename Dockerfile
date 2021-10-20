##########################
# Build Stage

FROM node:16-alpine

# Create app directory
WORKDIR /usr/src

# Install app dependencies

COPY ./package*.json ./

RUN npm ci --no-progress --no-audit --prefer-offline

COPY ./tsconfig*.json ./

# Bundle app source
COPY ./src/. ./src

# Run build
RUN npm run build

##########################
# Run Stage

FROM node:16-alpine

WORKDIR /usr/src

# Copy compiled files
COPY --from=0 /usr/src/package*.json ./

# Install packages needed for production
RUN npm ci --only=production --no-progress --no-audit --prefer-offline

COPY --from=0 /usr/src/dist/ ./



# Start process
CMD node --unhandled-rejections=strict main.js
