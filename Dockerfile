FROM python:3.8.1-alpine3.11

RUN pip install --no-cache-dir pipenv

WORKDIR /app
COPY Pipfile* ./
RUN pipenv install --system --deploy

COPY . .

CMD gunicorn -b :8000 app:app
EXPOSE 8000
