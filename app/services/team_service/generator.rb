module TeamService
  # This class is responsible for generating teams for blind date
  class Generator < ApplicationService
    attr_reader :blind_date

    def initialize(blind_date)
      @blind_date = blind_date
    end

    def call
      teams = []
      team_size = TeamService::TeamSizeCalculator.call
      employees = Employee.all.to_a

      Team.transaction do
        while employees.any?
          team = Team.create!(blind_date: blind_date)
          assign_employees!(team, employees.shift(team_size))
          find_leader!(team)
          teams << team
        end
      end

      teams
    end

    private

    def create_blind_date
      date =  Date.today.end_of_week - 2.days
      date += 1.week if date <= Date.today

      BlindDate.create!(
        date: Date.today.end_of_week - 2.days
      )
    end

    def assign_employees!(team, employees)
      employees.each do |employee|
        MappingEmployeeTeam.create!(
          employee: employee,
          team: team,
          role: :member
        )
      end
    end

    def find_leader!(team)
      team.mapping_employee_teams.sample.update!(role: :leader)
    end
  end
end
