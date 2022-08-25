# ローカルと合わせておく
FROM node:16.14.0-alpine

# 任意のtime zone設定にする
ENV TZ=Asia/Tokyo
RUN apk --no-cache add tzdata && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /app

COPY package*.json ./
RUN npm ci
COPY prisma ./prisma
RUN npm run prisma:generate

COPY . ./
RUN npm run build
RUN npm run prisma:migrate-deploy

EXPOSE 3000

ENTRYPOINT [ "npm", "run", "start:prod" ]