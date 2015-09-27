require_relative '../../config/environment'

lines = Line.all

lines.each do |line|
  $redis.set(line.line_number.to_s, line.line_text)
end

$redis.set("Line Count", lines.count)



