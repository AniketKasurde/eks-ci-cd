FROM python:3.10-slim

WORKDIR /app

COPY ./app.py /app
COPY requirements.txt /app

RUN pip install -r requirements.txt

# create a non-root user
RUN useradd -m appuser

# switch to non-root user
USER appuser

EXPOSE 5000

CMD ["python3", "app.py"]
