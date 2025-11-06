FROM n8nio/n8n:latest

USER root

# Instalar herramientas de compilación necesarias
RUN apk add --no-cache python3 make g++ git

# Instalar los paquetes de LangChain directamente con npm en el directorio global
# Esto evita conflictos con la configuración interna de pnpm de n8n
RUN npm install -g --prefix /usr/local \
    langchain@0.1.36 \
    @langchain/core@0.1.63 \
    @langchain/community@0.0.52 \
    @langchain/openai@0.0.28

# Crear enlaces simbólicos para que n8n pueda encontrar estos paquetes
# Esto es como crear atajos en tu computadora que apuntan a la ubicación real de los archivos
RUN cd /usr/local/lib/node_modules/n8n/node_modules && \
    ln -sf /usr/local/lib/node_modules/langchain langchain && \
    ln -sf /usr/local/lib/node_modules/@langchain @langchain

# Dar permisos correctos
RUN chown -R node:node /usr/local/lib/node_modules

USER node

WORKDIR /data

EXPOSE 5678

CMD ["n8n"]
