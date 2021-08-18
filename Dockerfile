FROM python:3.9-slim

ARG SECRET_KEY
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONBUFFERED 1
ENV USER app
ENV GROUP app

RUN groupadd $GROUP && useradd $USER -g $GROUP

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

# chown all the files to the app user
RUN chown -R $USER:$GROUP .

# create directory for statics
RUN mkdir /usr/src/staticfiles
RUN chown -R $USER:$GROUP /usr/src/staticfiles

# change to the app user
USER $USER

# collect static files
RUN python manage.py collectstatic --noinput

# run dev server
CMD gunicorn {{ project_name }}.wsgi:application --bind 0.0.0.0:8000
