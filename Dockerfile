FROM python:3.9-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONBUFFERED 1

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
        netcat \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

# install dependencies
RUN pip install --upgrade pip
COPY requirements.txt ./
RUN pip install -r requirements.txt

# copy source code to container
COPY ./src .

# collect statics
RUN mkdir /usr/src/staticfiles
RUN python manage.py collectstatic --noinput
