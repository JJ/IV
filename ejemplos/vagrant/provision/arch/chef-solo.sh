#!/bin/sh

# ruby 2.0 includes rubygems
pacman -S ruby make gcc
gem install chef ohai --no-user-install
