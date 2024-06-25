#!/bin/bash

service mysql start
mysql < /etc/mysql/init.sql
mysqld