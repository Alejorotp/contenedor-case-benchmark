FROM docker:latest  

WORKDIR /app  

COPY . /app  

RUN apk add --no-cache bash git python3 py3-pip  

CMD ["sh", "./run_benchmark.sh"]