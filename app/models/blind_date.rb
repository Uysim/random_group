# == Schema Information
#
# Table name: blind_dates
#
#  id         :integer          not null, primary key
#  date       :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class BlindDate < ApplicationRecord
  has_many :teams

  validates :date, presence: true, uniqueness: true
end
