require 'rails_helper'

RSpec.describe Line, type: :model do
  let(:line) { create(:line) }

  it "Has an line number that is an integer." do
    expect(line.line_number.is_a?(Integer)).to be true
  end

  it "Has text that is an string." do
    expect(line.line_text.is_a?(String)).to be true
  end

  it "Cannot save if it has the same line number as another line." do
    second_line = line.dup
    expect(second_line.save).to be false
  end

  it "Can save blank lines." do
    line.line_text = ""
    expect(line.save).to be true
  end

end
