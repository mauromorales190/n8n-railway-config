FROM n8nio/n8n:1.118.2

# Cambiar a usuario root para instalar dependencias del sistema
USER root

# Instalar herramientas necesarias para compilar módulos nativos
RUN apk add --no-cache \
    python3 \
    py3-pip \
    build-base \
    git

# Volver al usuario node (usuario de n8n)
USER node

# Instalar los paquetes de LangChain que faltan
RUN cd /usr/local/lib/node_modules/n8n && \
    npm install --save --legacy-peer-deps \
    langchain@0.1.25 \
    @langchain/core@0.1.52 \
    @langchain/community@0.0.45 \
    @langchain/openai@0.0.24

# Directorio de trabajo
WORKDIR /data

# Exponer puerto
EXPOSE 5678

# Comando de inicio
CMD ["n8n"]
