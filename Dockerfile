FROM node
RUN mkdir /src
COPY hello.js /src
CMD ["node","/src/hello.js"]