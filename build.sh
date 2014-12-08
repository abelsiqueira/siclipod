#!/bin/bash
version=$(gem build siclipod.gemspec | awk '/File/{print $2}')
gem install $version
