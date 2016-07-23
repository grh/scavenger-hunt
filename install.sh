#!/bin/bash

bundle install --deployment --without development test
bundle exec rake \
    db:drop \
    db:migrate \
    db:fixtures:load FIXTURES=roles,permissions,tasks,options \
    db:seed \
    assets:precompile \
    RAILS_ENV=production
