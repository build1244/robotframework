FROM python:3.9.0-alpine

COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

WORKDIR /robots
COPY robots .

CMD ["robot","--outputdir","results","robots"]
