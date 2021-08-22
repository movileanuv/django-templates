# django-templates
Start a new django project with 

```bash
django-admin startproject $PROJECT_NAME --template=https://github.com/ViggieSmalls/django-templates/archive/heroku.zip --name=Dockerfile --name=heroku.yml
```

Build docker image and run it
```bash
docker build -t $PROJECT_NAME:latest .
docker run --rm --name $PROJECT_NAME -p 8000:8000 -e "PORT=8000" $PROJECT_NAME:latest gunicorn $PROJECT_NAME.wsgi:application --bind 0.0.0.0:8000
```

### Deploy to heroku
```bash
export HEROKU_PROJECT_NAME=`heroku create | awk -F[/:] '{print $4}' | awk -F "." '{ print $1 }'`
heroku config:set SECRET_KEY=`tr -dc A-Za-z0-9 </dev/urandom | head -c 30 ; echo ''` -a $HEROKU_PROJECT_NAME
heroku config:set ALLOWED_HOSTS="$HEROKU_PROJECT_NAME.herokuapp.com" -a $HEROKU_PROJECT_NAME
heroku stack:set container -a $HEROKU_PROJECT_NAME
git init
heroku git:remote -a $HEROKU_PROJECT_NAME
git add --all
git commit -m "initial commit"
git push heroku master
```
