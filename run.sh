rake db:reset
redis-server
ruby db/loaders/create_lines_from_file.rb $1
ruby db/loaders/add_lines_to_redis.rb
rails s
