FROM dhi.io/bun:1-debian13-dev AS builder

WORKDIR /app
COPY frontend/package.json frontend/bun.lock ./

RUN bun install --frozen-lockfile

COPY frontend/ .

RUN bun run build 

FROM dhi.io/nginx:1-compat

COPY --from=builder --chown=65532:65532 /app/dist /usr/share/nginx/html

EXPOSE 8080