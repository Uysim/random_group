require 'rails_helper'

RSpec.describe TeamService::TeamSizeCalculator do
  it "calculates team size with equal and between +1/-1" do
    allow(Employee).to receive(:count).and_return(10)
    team_size, total_teams = described_class.call
    expect(team_size).to eq(2)
    expect(total_teams).to eq(5)

    allow(Employee).to receive(:count).and_return(17)
    team_size, total_teams = described_class.call
    expect(team_size).to eq(6)
    expect(total_teams).to eq(3)

    allow(Employee).to receive(:count).and_return(60)
    team_size, total_teams = described_class.call
    expect(team_size).to eq(20)
    expect(total_teams).to eq(3)
  end
end
