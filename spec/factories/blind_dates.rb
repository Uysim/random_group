# == Schema Information
#
# Table name: blind_dates
#
#  id         :integer          not null, primary key
#  date       :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :blind_date do
    date { "2023-04-28" }
  end
end
