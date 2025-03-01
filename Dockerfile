FROM openjdk:11-jre-slim

WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ant \
    xsltproc \
    && rm -rf /var/lib/apt/lists/*

COPY . .

RUN chmod +x index.sh

ENTRYPOINT ["./index.sh"]