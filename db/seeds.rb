current_directory = File.dirname(__FILE__)
line_file_name = "/data/sample_file.txt"

line_file = File.join(current_directory, line_file_name)

lines = File.readlines(line_file)

lines.each_with_index do |line, index|

  puts line

end


