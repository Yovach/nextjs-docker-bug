FROM node:22.13.0-alpine AS base

USER node
WORKDIR /app

EXPOSE 3000

ENV HOSTNAME=0.0.0.0
ENV COREPACK_INTEGRITY_KEYS=0

ENV PATH="/home/node/.corepack/:$PATH"

# Copy package.json AND package-lock.json
COPY --chown=node:node package*.json ./
RUN mkdir -p ~/.corepack/ \
      && corepack enable --install-directory ~/.corepack/ \
      && corepack install

RUN corepack npm install

COPY --chown=node:node . .

CMD ["corepack", "npm", "run", "dev"]
