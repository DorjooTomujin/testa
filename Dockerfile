FROM node:18
WORKDIR /nestapp
COPY package*.json .
COPY yarn.lock .
COPY pnpm-lock.yaml .
RUN yarn
COPY . . 
RUN yarn build
EXPOSE 3000
CMD [ "yarn", "start" ]

