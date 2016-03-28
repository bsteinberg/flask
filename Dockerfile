################################################################################
# Dockerfile to build image with Flask
#
# Based on: debian:jessie
#
# Created On: Mar 26, 2015
#
# Author: Baruch Steinberg <baruch.steinberg@gmail.com>
################################################################################

## Set the base image
FROM debian:jessie

## File maintainer
MAINTAINER Baruch Steinberg

## Update OS packages
RUN apt-get -y update
RUN apt-get -y upgrade

ENV FLASK_VERSION 0.10
ENV APP_PATH /usr/local/app

################################################################################
#
# INSTALLATION
#
################################################################################

## Configure OS to be aware that there is no tty
## -----------------------------------------------------------------------------
ENV DEBIAN_FRONTEND noninteractive

## Install basic requirements
## -----------------------------------------------------------------------------
RUN apt-get update \
    && apt-get install -y \
       curl \
    && rm -rf /var/lib/apt/lists/*

## Install Python & Python PIP
## -----------------------------------------------------------------------------
RUN apt-get update \
    && apt-get install -y \
       python \
    && rm -rf /var/lib/apt/lists/*

RUN curl -O https://bootstrap.pypa.io/get-pip.py \
    && python get-pip.py

## Install Flask
## -----------------------------------------------------------------------------
RUN pip install flask==$FLASK_VERSION

################################################################################
#
# CONFIGURATION
# 
################################################################################

## Create application direcory: 
## -----------------------------------------------------------------------------
RUN mkdir $APP_PATH

## Add sample app:
## -----------------------------------------------------------------------------
ADD main.py $APP_PATH/.

################################################################################
#
# RUN
# 
################################################################################

## Set working dir
## -----------------------------------------------------------------------------
WORKDIR $APP_PATH

## Expose ports:
## -----------------------------------------------------------------------------
EXPOSE 5000

## Define container cmd:
## -----------------------------------------------------------------------------
CMD ["python", "main.py"]
