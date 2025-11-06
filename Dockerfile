FROM n8nio/n8n:latest

USER root

# Instalar herramientas de compilación necesarias
RUN apk add --no-cache python3 make g++ git

# Instalar los paquetes de LangChain de forma global
RUN npm install -g \
    langchain@latest \
    @langchain/core@latest \
    @langchain/community@latest \
    @langchain/openai@latest

USER node

WORKDIR /data

EXPOSE 5678

CMD ["n8n"]
