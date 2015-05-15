docker build -t es-gmail-docker

docker run -ti --rm=true -v <source>:/tmp -p 8080:8080 -p 9200:9200 es-gmail-docker

(with mails.mbox in <source>)
