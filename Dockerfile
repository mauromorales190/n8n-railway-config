FROM n8nio/n8n:latest

USER root

RUN apk add --no-cache python3 make g++ git

USER node

ENV NODE_FUNCTION_ALLOW_BUILTIN=*
ENV NODE_FUNCTION_ALLOW_EXTERNAL=*

WORKDIR /data

EXPOSE 5678

CMD ["n8n"]
