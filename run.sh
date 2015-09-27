rake db:reset
ruby db/loaders/create_lines_from_file.rb $1
rails s
