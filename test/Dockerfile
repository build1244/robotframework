FROM python:3.9.0-alpine 

RUN pip install --upgrade pip
RUN pip install robotframework
RUN pip install robotframework-selenium2library
RUN apk add bash py-pip firefox xvfb dbus chromium chromium-chromedriver 

ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

CMD ["run.sh"]
