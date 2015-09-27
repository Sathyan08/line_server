require_relative '../../config/environment'

Line.all.each do |line|
  $redis.set(line.line_number.to_s, line.line_text)
end
