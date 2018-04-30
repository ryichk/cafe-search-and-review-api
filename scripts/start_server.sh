#!/bin/bash
su -l deploy -c 'cd /var/www/cafeshares && bundle exec unicorn -D -E production -c config/unicorn.rb'