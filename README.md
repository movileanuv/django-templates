# django-templates
Start a new django project with 

```bash
django-admin startproject <project name> --template=https://github.com/ViggieSmalls/django-templates/archive/heroku.zip --name=Dockerfile --name=heroku.yml
```

Build docker image and run it
```bash
docker build -t django-heroku:latest --build-arg SECRET_KEY=fox .
docker run --rm --name django-heroku -p 8000:8000 -e "SECRET_KEY=fox" django-heroku:latest
```
The first worker might crash on startup. This might be related to [this FAQ](https://docs.gunicorn.org/en/stable/faq.html#why-are-workers-silently-killed) on gunicorn.

## deploy to heroku
```bash
heroku create
heroku config:set SECRET_KEY="<random characters>" -a <app name>
heroku config:set ALLOWED_HOSTS="<app name>.herokuapp.com" -a <app name>
heroku stack:set container -a <app name>
git init
heroku git:remote -a <app name>
git add --all
git commit -m "initial commit"
git push heroku master
```
