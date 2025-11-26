ARG BUILD_FROM
FROM $BUILD_FROM

# Install requirements for add-on
RUN \
  apk add --no-cache \
  python3 \
  py3-pip

# Copy data for add-on
COPY run.sh /
COPY . /app

WORKDIR /app

# Install Python dependencies
RUN pip3 install --upgrade flask google-generativeai --break-system-packages

RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
