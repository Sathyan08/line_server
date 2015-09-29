require 'rails_helper'

RSpec.describe Line, type: :model do
  let(:line) { create(:line) }

  it "Has an line number that is an integer." do
    line = create(:line)
    expect(line.line_number.is_a?(Integer)).to be true
  end

  it "Has text that is an string." do
    line = create(:line)
    expect(line.line_text.is_a?(String)).to be true
  end
end
