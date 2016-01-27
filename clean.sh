#!/bin/bash

rm -rf /root/redmine
docker rm -f redmine
docker rm -f redmine-postgres

