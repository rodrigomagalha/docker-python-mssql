FROM python:3.9.6

ENV PYTHONHONUNBUFFERED 1

ENV ACCEPT_EULA=Y
# Make app folder writable for the sake of db.sqlite3, and make that file also writable.
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \ 
    && curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update \
    && apt-get install -y msodbcsql17 \
    && apt-get install -y mssql-tools

ENV PATH=$PATH:/opt/mssql-tools/bin

RUN  apt-get install -y unixodbc-dev

# Setup locale, Oracle instant client and Python
RUN apt-get update \
    && apt-get install -y locales \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && sed -i -e 's/# pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen
