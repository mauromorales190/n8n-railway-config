FROM n8nio/n8n:latest

# Mantenernos como root para todas las instalaciones
USER root

# Instalar herramientas de compilación necesarias
RUN apk add --no-cache python3 make g++ git

# Instalar pnpm globalmente
RUN npm install -g pnpm

# Instalar los paquetes de LangChain usando pnpm
# Lo hacemos como root para tener permisos de escritura
RUN cd /usr/local/lib/node_modules/n8n && \
    pnpm install langchain @langchain/core @langchain/community @langchain/openai --filter n8n

# Dar permisos correctos a todos los archivos de n8n
# Esto asegura que el usuario node pueda leer y usar los paquetes instalados
RUN chown -R node:node /usr/local/lib/node_modules/n8n

# AHORA sí cambiamos al usuario node para ejecutar n8n
USER node

WORKDIR /data

EXPOSE 5678

CMD ["n8n"]
