# == Schema Information
#
# Table name: employees
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Employee, type: :model do
  context 'validations' do
    it{ is_expected.to validate_presence_of(:name) }
  end

  context 'associations' do
    it { is_expected.to have_many(:mapping_employee_teams) }
    it { is_expected.to have_many(:teams).through(:mapping_employee_teams) }
  end
end
