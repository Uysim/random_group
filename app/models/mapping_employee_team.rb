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
class MappingEmployeeTeam < ApplicationRecord
  belongs_to :team
  belongs_to :employee

  # use string instead of integer for data consistency
  enum role: { member: 'member', leader: 'leader' }

  validates :role, presence: true
  validates :employee_id, uniqueness: { scope: :team_id }
  validate :single_leader_per_team, if: :leader?

  private

  def single_leader_per_team
    leader = self.class.where.not(
      employee_id: employee_id
    ).find_by(
      team_id: team_id, role: 'leader'
    )

    errors.add(:role, 'cannot have multiple leaders') if leader.present?
  end
end
