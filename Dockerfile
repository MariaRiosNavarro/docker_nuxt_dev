FROM node:18
WORKDIR /nuxt
COPY . .
EXPOSE 3000
CMD ["npm","run", "dev", "--", "--host"]