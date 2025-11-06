FROM n8nio/n8n:1.118.2

USER root

RUN apk add --no-cache \
    python3 \
    py3-pip \
    build-base \
    git

USER node

RUN cd /usr/local/lib/node_modules/n8n && \
    npm install --save --legacy-peer-deps \
    langchain@0.1.25 \
    @langchain/core@0.1.52 \
    @langchain/community@0.0.45 \
    @langchain/openai@0.0.24

WORKDIR /data

EXPOSE 5678

CMD ["n8n"]
