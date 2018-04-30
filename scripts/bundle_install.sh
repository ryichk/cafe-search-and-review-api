#!/bin/bash
su -l deploy -c 'cd /var/www/cafeshares && bundle install --path vendor/bundle'