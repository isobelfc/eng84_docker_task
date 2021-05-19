# Dockerfile to load plane project

FROM python:3.7

LABEL MAINTAINER = isobelfc

# RUN apt-get update

# \
#     && apt-get install unixodbc -y \
#     && apt-get install unixodbc-dev -y \
#     && apt-get install freetds-dev -y \
#     && apt-get install freetds-bin -y \
#     && apt-get install tdsodbc -y \
#     && apt-get install --reinstall build-essential -y

# RUN ACCEPT_EULA=Y apt-get install -y --allow-unauthenticated msodbcsql17
# RUN ACCEPT_EULA=Y apt-get install -y --allow-unauthenticated mssql-tools

WORKDIR /usr/src/app

# ENV FLASK_APP=app.py
# ENV FLASK_RUN_HOST=0.0.0.0

# ENV ODBCSYSINI=/usr/src/app

COPY requirements.txt requirements.txt

RUN python -m pip install -r requirements.txt

COPY eng84-airport-project/ .

# Django is on port 8000
EXPOSE 8000

# make migrations
WORKDIR /usr/src/app/app
RUN python manage.py makemigrations
RUN python manage.py migrate

# run app
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
