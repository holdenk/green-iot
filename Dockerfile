FROM python:3.9.4-buster
RUN apt-get install libmysqlclient-dev  libpq-dev python3-dev
# Static files
COPY nginx.default /etc/nginx/sites-available/default
# Make nginx logging go to stdout/stderr for debugging
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log
# Django stuff
ENV PYTHONUNBUFFERED=1
RUN mkdir /opt/app
WORKDIR /opt/app
COPY . /opt/app
RUN pip install -r /opt/app/requirements.txt --no-cache-dir
RUN chown -R www-data:www-data /django
EXPOSE 8020
STOPSIGNAL SIGTERM
CMD ["/opt/app/start-server.sh"]
