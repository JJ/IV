#!/bin/sh

#Taken from https://gist.github.com/cmaitchison/3377486

yum install -y  ruby ruby-devel ruby-docs ruby-ri ruby-rdoc  rubygems
gem install chef ruby-shadow ohai
