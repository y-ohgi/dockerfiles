FROM python:3-slim

WORKDIR /app

COPY ./requirements.txt ./requirements.txt

RUN apt update \
  && pip install -r requirements.txt \
  && groupadd -g 1000 app \
  && useradd -u 1000 -g app app \
  && chown -R app:app /app

COPY . .

USER app

EXPOSE 8630
CMD ["python", "app.py"]
