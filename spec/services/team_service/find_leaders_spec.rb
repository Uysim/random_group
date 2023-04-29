require 'rails_helper'

RSpec.describe TeamService::FindLeaders do
  context 'when previous blind date is provided' do
    let!(:blind_date) { create(:blind_date) }
    let!(:prev_blind_date) { create(:blind_date, date: 1.week.ago.to_date) }
    let!(:prev_team) { create(:team, blind_date: prev_blind_date) }
    let!(:team) { create(:team, blind_date:) }
    let!(:employee1) { create(:employee) }
    let!(:employee2) { create(:employee) }

    before do
      create(:mapping_employee_team, team: prev_team, employee: employee1, role: :member)
      create(:mapping_employee_team, team: prev_team, employee: employee2, role: :leader)

      create(:mapping_employee_team, team: team, employee: employee1, role: :member)
      create(:mapping_employee_team, team: team, employee: employee2, role: :member)
    end

    it 'select different leader for team' do
      described_class.call([team], prev_blind_date)

      expect(team.mapping_employee_teams.leader.first.employee).to eq(employee1)
    end
  end

  context 'when previous blind date is not provided' do
    let!(:team) { create(:team) }
    let!(:mapping_employee_team) { create_list(:mapping_employee_team, 3, team:, role: :member) }

    it 'randomly selects a leader for teams' do
      described_class.call([team])

      expect(team.mapping_employee_teams.leader.count).to eq(1)
    end
  end
end
