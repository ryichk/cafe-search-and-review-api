#!/bin/bash
su -l deploy -c 'kill -KILL -s QUIT `cat /var/www/cafeshares/tmp/pids/unicorn.pid`'