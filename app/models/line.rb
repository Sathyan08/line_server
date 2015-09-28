class Line < ActiveRecord::Base

  validates :line_number, presence: true, uniqueness: true
  validates :line_text, presence: true

  def self.find_by_redis(key)
    $redis.get(key)
  end

  def self.count_from_redis
    $redis.get("Line Count").to_i
  end

end
