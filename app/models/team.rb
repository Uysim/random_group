# == Schema Information
#
# Table name: teams
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  blind_date_id :integer          not null
#
# Indexes
#
#  index_teams_on_blind_date_id  (blind_date_id)
#
# Foreign Keys
#
#  blind_date_id  (blind_date_id => blind_dates.id)
#
class Team < ApplicationRecord
  belongs_to :blind_date
  has_many :mapping_employee_teams
  has_many :employees, through: :mapping_employee_teams
end
