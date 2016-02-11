rake db:drop
rake db:migrate
rake db:fixtures:load
rails server -b $IP -p $PORT
