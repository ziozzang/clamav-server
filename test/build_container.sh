#!/bin/bash
DOCKER_TAGS=${DOCKER_TAGS:-'ziozzang/clamav-server'}
CURR_IP=$(hostname -I | awk '{print $1}')


docker build -t ${DOCKER_TAGS} ..


