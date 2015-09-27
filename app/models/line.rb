class Line < ActiveRecord::Base

  validates :line_number, presence: true, uniqueness: true
  validates :line_text, presence: true

end
