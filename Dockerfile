FROM node:14.17.2 as build

WORKDIR /app

ARG apihost
ENV REACT_APP_API_HOST=$apihost

COPY package.json yarn.lock ./
RUN yarn install

COPY . ./
RUN yarn build

# production environment
FROM nginx
COPY --from=build /app/build /app