FROM python:3.8.2-slim-buster AS builder
RUN pip install --no-cache-dir pipenv
COPY Pipfile* ./
RUN pipenv lock --requirements > requirements.txt

FROM python:3.8.2-slim-buster
WORKDIR /app
COPY --from=builder /requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
CMD gunicorn -b :8000 app:app
EXPOSE 8000
