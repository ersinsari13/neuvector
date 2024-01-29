FROM python:3.9

WORKDIR /app

COPY bus_app/requirements.txt .

RUN python3 -m pip install --no-cache-dir -r requirements.txt

ENV FLASK_ENV=development

COPY bus_app/ .

CMD ["python3", "app.py"]