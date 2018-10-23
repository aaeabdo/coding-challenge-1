FROM node:10 as builder

RUN npm install -g api-console-cli

RUN mkdir /api

WORKDIR /api

#
# cache api console dependencies
#
COPY ./examples/example.raml .
RUN api-console build --verbose -a example.raml -t "RAML 1.0" -n "5.0.0-preview"

ADD . .

RUN api-console build --verbose -a main.raml -t "RAML 1.0" -n "5.0.0-preview"
RUN api-console generate-json
EXPOSE 9000

ENTRYPOINT ["api-console", "serve", "-H", "0.0.0.0", "-p", "9000", "./build"]
