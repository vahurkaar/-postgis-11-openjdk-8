#!/bin/sh

/usr/local/bin/docker-entrypoint.sh "$@" & /run-java.sh
