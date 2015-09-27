current_directory = File.dirname(__FILE__)
line_file_name = "/data/sample_file.txt"

line_file = File.join(current_directory, line_file_name)

lines = File.readlines(line_file)

lines.each_with_index do |line_text, index|
  line_number = index + 1
  clean_text = line_text.strip.gsub(/\n/, '')
  new_line = Line.create(line_number: line_number, line_text: clean_text)
end


