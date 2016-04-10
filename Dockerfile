FROM docker:1.9.1

ADD add-host-to-docker.sh /usr/local/bin/add-host-to-docker.sh

CMD ["add-host-to-docker.sh"]
