module BlindDateService
  # This class is responsible for create blind date on friday
  class Create < ApplicationService
    def call
      BlindDate.transaction do
        date = find_date
        blind_date = BlindDate.create!(
          date: date
        )

        TeamService::Generator.call(blind_date)

        blind_date
      end
    end

    private

    def find_date
      date =  Date.today.end_of_week - 2.days
      date += 1.week if date <= Date.today

      date
    end
  end
end
