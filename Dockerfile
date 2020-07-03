FROM ubuntu
USER root
ENV TZ=Asia/Bangkok
RUN apt-get update && \
apt-get -y install python3 \
 python3-pip \
 unzip \
 wget \
 xvfb  && \
ln -snf /usr/share/zoneinfo/Asia/Bangkok /etc/localtime && \
dpkg-reconfigure -f noninteractive tzdata && \
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
dpkg -i google-chrome-stable_current_amd64.deb; apt-get install -f -y && \
CHROMEDRIVER_VERSION=`wget --no-verbose --output-document - https://chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
    wget --no-verbose --output-document /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
    unzip -qq /tmp/chromedriver_linux64.zip -d /opt/chromedriver && \
    chmod +x /opt/chromedriver/chromedriver && \
    ln -fs /opt/chromedriver/chromedriver /usr/local/bin/chromedriver && \
rm -rf /var/lib/apt/lists/*

COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt
#RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
#apt install ./google-chrome-stable_current_amd64.deb; apt-get install --fix-broken -y install

#RUN CHROMEDRIVER_VERSION=`wget --no-verbose --output-document - https://chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
#    wget --no-verbose --output-document /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
#    unzip -qq /tmp/chromedriver_linux64.zip -d /opt/chromedriver && \
#    chmod +x /opt/chromedriver/chromedriver && \
#    ln -fs /opt/chromedriver/chromedriver /usr/local/bin/chromedriver

ENTRYPOINT ["sh","/app/run_tests.sh"]
