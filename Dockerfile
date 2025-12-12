
FROM python:alpine

WORKDIR /app

COPY ./requirements.txt .

RUN pip install -r requirements.txt

COPY . .

EXPOSE 8000

ENTRYPOINT ["hypercorn", "main:app", "--bind", "0.0.0.0:8000"]
