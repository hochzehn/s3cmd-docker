FROM python:3.9.19-alpine3.20

RUN apk add --no-cache git ca-certificates
RUN pip install --no-cache-dir python-dateutil python-magic
RUN git clone --depth=1 https://github.com/s3tools/s3cmd /opt/s3cmd
RUN rm -rf /opt/s3cmd/.git
RUN ln -s /opt/s3cmd/s3cmd /usr/bin/s3cmd

ADD ./files/.s3cfg /root/.s3cfg
ADD ./files/main.sh /opt/main.sh

# Main entrypoint script and directories for s3cmd
RUN chmod u+x /opt/main.sh \
 && mkdir /opt/src /opt/dest

ENTRYPOINT ["/opt/main.sh"]
CMD [""]
