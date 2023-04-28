FactoryBot.define do
  factory :mapping_employee_team do
    employee
    team
    role { 'member' }

    trait :leader do
      role { 'leader' }
    end
  end
end
