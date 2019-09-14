FROM ubuntu:xenial
MAINTAINER Satish "satishkumard@gmail.com"

EXPOSE 8080/tcp
RUN apt-get update
RUN apt-get install -y python-pip python-dev

COPY app/* /app/

WORKDIR /app
RUN pip install -r requirements.txt

ENTRYPOINT ["python"]
CMD ["site.py"]