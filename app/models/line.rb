class Line < ActiveRecord::Base

  validates :line_number, presence: true, uniqueness: true
  validates :line_text, presence: true

  def self.find_from_redis(key)
    $redis.get(key)
  end

  def self.line_count_from_redis
    $redis.get("Line Count").to_i
  end

  def self.exceeds_line_count?(request)
    line_number = request.to_i
    line_number > self.line_count_from_redis
  end

  def self.check_if_exceeds_line_count?(request)
    if self.exceeds_line_count?(request)
      raise StandardError.new("You requested line #{ request }, but the max line count is only #{ Line.line_count_from_redis }")
    end
  end

end
