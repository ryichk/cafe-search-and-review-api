#!/bin/bash
cd /home/ec2-user/cafeshares && bundle exec unicorn -D -E production -c config/unicorn.rb