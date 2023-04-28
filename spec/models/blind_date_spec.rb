# == Schema Information
#
# Table name: blind_dates
#
#  id         :integer          not null, primary key
#  date       :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe BlindDate, type: :model do
  it { is_expected.to have_many(:teams) }
end
