FROM node:alpine as builder

WORKDIR /app

COPY package.json .

RUN npm i

COPY . .

RUN npm run build
#the above step will spit out a build directory,
# and those files are the only things that matter in prod,
# the dependencies are no longer required, therefore we make a server to serve those files
FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html

