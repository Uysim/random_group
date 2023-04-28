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
require 'rails_helper'

RSpec.describe Team, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:blind_date) }
    it { is_expected.to have_many(:mapping_employee_teams) }
    it { is_expected.to have_many(:employees).through(:mapping_employee_teams) }
  end
end
