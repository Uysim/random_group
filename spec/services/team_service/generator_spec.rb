require 'rails_helper'

RSpec.describe TeamService::Generator do
  let!(:employees) { create_list(:employee, 10) }

  it 'generates teams with equal size' do
    teams = described_class.call

    expect(teams.size).to be > 1
    team_size = teams.first.employees.count
    teams.each do |team|
      expect(team.employees.count).to be_between(team_size - 1, team_size + 1)
      expect(team.mapping_employee_teams.where(role: 'leader').count).to eq(1)
    end
  end
end
