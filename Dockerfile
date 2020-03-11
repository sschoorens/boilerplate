FROM debian:10

RUN apt-get update && \
	apt-get install -y python3-coverage make vulture flake8 python3-pip

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

COPY dev-requirements.txt /tmp/dev-requirements.txt

RUN pip3 install -r /tmp/dev-requirements.txt