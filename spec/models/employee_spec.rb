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
end
