# == Schema Information
#
# Table name: employees
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Employee < ApplicationRecord
  has_many :mapping_employee_teams
  has_many :teams, through: :mapping_employee_teams

  validates :name, presence: true
end
