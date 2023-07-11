#!/bin/bash -e

docker build -t tpedpfhgspl .
docker run -v ./assets:/app/assets -it tpedpfhgspl bash

exit 0
