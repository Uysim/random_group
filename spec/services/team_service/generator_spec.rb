require 'rails_helper'

RSpec.describe TeamService::Generator do
  context 'without previous blind date' do
    let!(:employees) { create_list(:employee, 10) }
    let!(:blind_date) { create(:blind_date) }

    it 'generates teams with equal size' do
      described_class.call(blind_date)

      teams = blind_date.teams
      expect(teams.size).to be > 1
      team_size = teams.first.employees.count
      teams.each do |team|
        expect(team.employees.count).to be_between(team_size - 1, team_size + 1)
        expect(team.mapping_employee_teams.where(role: 'leader').count).to eq(1)
      end
    end
  end

  context 'with previous blind date' do
    let!(:blind_date) { create(:blind_date) }
    let!(:prev_blind_date) { create(:blind_date, date: 1.week.ago.to_date) }
    let!(:team1) { create(:team, blind_date: prev_blind_date) }
    let!(:team2) { create(:team, blind_date: prev_blind_date) }
    let!(:employee1) { create(:employee) }
    let!(:employee2) { create(:employee) }
    let!(:employee3) { create(:employee) }
    let!(:employee4) { create(:employee) }

    before do
      create(:mapping_employee_team, team: team1, employee: employee1, role: :leader)
      create(:mapping_employee_team, team: team1, employee: employee2, role: :member)
      create(:mapping_employee_team, team: team2, employee: employee3, role: :leader)
      create(:mapping_employee_team, team: team2, employee: employee4, role: :member)
    end

    it 'generates new teams with differnt leader' do
      stub_const('TeamService::TeamSizeCalculator::TEAM_SIZE', 2)

      described_class.call(blind_date, prev_blind_date)

      teams = blind_date.teams
      mapping = teams.map(&:mapping_employee_teams).flatten
      leaders = mapping.select(&:leader?).map(&:employee)
      expect(leaders).to include(employee2, employee4)
      expect(leaders).not_to include(employee1, employee3)
    end
  end
end
