# syntax = docker/dockerfile:1.2

FROM python:3.12-slim as python
ENV PYTHONUNBUFFERED=true
WORKDIR /app


FROM python as poetry
ENV POETRY_VIRTUALENVS_IN_PROJECT=true
ENV PATH="$POETRY_HOME/bin:$PATH"
RUN pip install poetry
COPY poetry.lock pyproject.toml ./
RUN poetry install --only main --no-interaction --no-ansi -vvv
COPY . .


FROM python as runtime
ENV PATH="/app/.venv/bin:$PATH"
COPY --from=poetry /app /app
CMD ["gunicorn", "-b", ":8000", "app:app"]
EXPOSE 8000
