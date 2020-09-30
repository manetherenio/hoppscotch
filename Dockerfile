FROM node:12.18-alpine

LABEL maintainer="Liyas Thomas (liyascthomas@gmail.com)"

# Add git as the prebuild target requires it to parse version information
RUN apk add --update --no-cache \
  git \
  python2 \
  make \
  g++ \
  chromium

# Create app directory
WORKDIR /app
ADD . /app/

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run generate

ENV HOST 0.0.0.0
EXPOSE 3000

CMD ["sh", "-c", "npm run start & sleep 5 && chromium-browser --test-type --no-sandbox --app=http://localhost:3000"]
