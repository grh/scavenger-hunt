#!/bin/bash

bundle install
bundle update
rake db:drop
rake db:migrate
rake db:fixtures:load