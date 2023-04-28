require 'rails_helper'

RSpec.describe TeamService::TeamSizeCalculator do
  it "calculates team size with equal and between +1/-1" do
    allow(Employee).to receive(:count).and_return(10)
    expect(described_class.call).to eq(2)

    allow(Employee).to receive(:count).and_return(17)
    expect(described_class.call).to eq(6)

    allow(Employee).to receive(:count).and_return(60)
    expect(described_class.call).to eq(20)
  end
end
