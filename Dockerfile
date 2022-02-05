FROM node:alpine as builder

RUN cd home \
    && mkdir ret

RUN chmod -R 777 /home/ret

WORKDIR /home/ret

COPY package.json ./

RUN npm install

COPY ./ ./

RUN npm run build

FROM nginx

COPY --from=builder /home/ret/build /usr/share/nginx/html

