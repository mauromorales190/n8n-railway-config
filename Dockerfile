FROM n8nio/n8n:latest

USER root

# Instalar herramientas de compilación necesarias
RUN apk add --no-cache python3 make g++ git

# Instalar pnpm globalmente (el gestor de paquetes que n8n usa)
RUN npm install -g pnpm

# Cambiar al usuario node
USER node

# Navegar al directorio de n8n e instalar las dependencias usando pnpm
RUN cd /usr/local/lib/node_modules/n8n && \
    pnpm install langchain @langchain/core @langchain/community @langchain/openai --filter n8n

USER root

# Dar permisos correctos a los archivos instalados
RUN chown -R node:node /usr/local/lib/node_modules/n8n/node_modules

USER node

WORKDIR /data

EXPOSE 5678

CMD ["n8n"]
