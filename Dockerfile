FROM python:3.8.9-alpine3.13

WORKDIR /app

COPY ./build/web/* /app/

ENTRYPOINT ["python", "-m", "http.server"]