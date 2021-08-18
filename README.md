# django-templates
Start a new django project with 

```bash
django-admin startproject <project name> --template=<url to this project> --name=Dockerfile
```

Build docker image and run it
```bash
docker build -t django-heroku:latest --build-arg SECRET_KEY=foo .
docker run --rm --name django-heroku -p 8000:8000 -e "SECRET_KEY=fox" django-heroku:latest
```
The first worker needs a bit longer on startup. This might be related to [this FAQ](https://docs.gunicorn.org/en/stable/faq.html#why-are-workers-silently-killed) on gunicorn.
