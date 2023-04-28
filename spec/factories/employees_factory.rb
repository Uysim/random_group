FactoryBot.define do
  factory :employee do
    name { Faker::Name.name }
  end
end
