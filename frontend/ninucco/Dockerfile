# 베이스 이미지
FROM node:16.18.1

# 이미지 내부 작업공간 설정
WORKDIR /home/A605

COPY ./package.json .

RUN npm install

COPY . .

CMD ["npm", "run", "dev"]