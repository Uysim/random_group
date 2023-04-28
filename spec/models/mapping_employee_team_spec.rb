# == Schema Information
#
# Table name: mapping_employee_teams
#
#  id          :integer          not null, primary key
#  role        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  employee_id :integer          not null
#  team_id     :integer          not null
#
# Indexes
#
#  index_mapping_employee_teams_on_employee_id              (employee_id)
#  index_mapping_employee_teams_on_team_id                  (team_id)
#  index_mapping_employee_teams_on_team_id_and_employee_id  (team_id,employee_id) UNIQUE
#
# Foreign Keys
#
#  employee_id  (employee_id => employees.id)
#  team_id      (team_id => teams.id)
#
require 'rails_helper'

RSpec.describe MappingEmployeeTeam, type: :model do
  context 'validations' do
    subject { build(:mapping_employee_team) }
    it { is_expected.to validate_presence_of(:role) }
    it { is_expected.to validate_uniqueness_of(:employee_id).scoped_to(:team_id) }
  end

  context 'associations' do
    it { is_expected.to belong_to(:team) }
    it { is_expected.to belong_to(:employee) }
  end
end
