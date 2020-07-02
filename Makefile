SHELL := /bin/bash
include ./Makefile.host
include ./Makefile.include

# this Makefile doesn't do much, but the Dockerfile is just a build image
# other images will include the Makefile.include
# just make build

build:
	sudo docker build -t "$(REPONAME):$(IMAGENAME)" .
