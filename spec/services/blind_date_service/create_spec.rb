require 'rails_helper'

RSpec.describe BlindDateService::Create do
  let!(:employees) { create_list(:employee, 10) }

  it 'creates blind dates with teams' do
    blind_date = described_class.call

    expect(blind_date).to be_present

    teams = blind_date.teams
    expect(teams.size).to be > 1
  end
end
