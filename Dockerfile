FROM softinstigate/lektor
COPY lektor-app/requirements.txt .
RUN pip install -r requirements.txt
COPY lektor-app/. /appdir
WORKDIR /appdir
ENTRYPOINT ["lektor", "server",  "-f","webpack", "--host", "0.0.0.0"]