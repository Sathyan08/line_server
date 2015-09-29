FactoryGirl.define do

  factory :line do
    sequence(:line_number) { |n| n }
    sequence(:line_text) { |n| n.to_s }
  end

end
