#!/bin/sh

# avoid using platform specific gems that cause a hash error
bundle config set force_ruby_platform true
bundle update
bundle lock
bundle install
bundix
