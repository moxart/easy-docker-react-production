FROM node:alpine as build

WORKDIR app/

COPY ./react-app/package.json ./react-app/yarn.lock ./

RUN yarn

COPY ./react-app/ ./
RUN yarn run build

FROM nginx:latest
COPY --from=build /app/build /usr/share/nginx/html
COPY ./nginx/default.conf /etc/nginx/default.conf

