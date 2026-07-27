FROM python:3.8-slim

ENV APP_DIR=/usr/src/snappass

RUN groupadd -r snappass && \
    useradd -r -g snappass snappass && \
    mkdir -p $APP_DIR

WORKDIR $APP_DIR

COPY ["pyproject.toml", "requirements.txt", "MANIFEST.in", "README.rst", "AUTHORS.rst", "LICENSE", "$APP_DIR/"]
COPY ["./snappass", "$APP_DIR/snappass"]

RUN pip install -r requirements.txt

RUN pybabel compile -d snappass/translations

RUN pip install . && \
    chown -R snappass $APP_DIR && \
    chgrp -R snappass $APP_DIR

USER snappass

# Default Flask port
EXPOSE 5000

CMD ["snappass"]
