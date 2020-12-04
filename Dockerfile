# FROM node:10 as builder
# WORKDIR /app
# COPY package*.json ./
# RUN npm install
# COPY . .
# ARG APP_MOUNT_URI
# ARG API_URI
# ARG STATIC_URL
# ENV API_URI ${API_URI:-http://localhost:8000/graphql/}
# ENV APP_MOUNT_URI ${APP_MOUNT_URI:-/dashboard/}
# ENV STATIC_URL ${STATIC_URL:-/dashboard/}
# RUN STATIC_URL=${STATIC_URL} API_URI=${API_URI} APP_MOUNT_URI=${APP_MOUNT_URI} npm run build
# EXPOSE 9000

# FROM nginx:stable
# WORKDIR /app
# COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
# COPY --from=builder /app/build/ /app/
# CMD npm start -- --host 0.0.0.0 --verbose

# ===dev===
FROM node:10

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
ARG API_URI
ARG APP_MOUNT_URI
ENV API_URI=http://localhost/graphql/
ENV APP_MOUNT_URI ${APP_MOUNT_URI:-/dashboard/}
ENV STATIC_URL ${STATIC_URL:-/dashboard/}

EXPOSE 9000
CMD npm start -- --host 0.0.0.0
