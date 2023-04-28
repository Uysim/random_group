module TeamService
  # This class is responsible for generating teams
  class Generator < ApplicationService
    def call
      teams = []
      team_size = TeamService::TeamSizeCalculator.call
      employees = Employee.all.to_a

      Team.transaction do
        while employees.any?
          team = Team.create!
          assign_employees!(team, employees.shift(team_size))
          find_leader!(team)
          teams << team
        end
      end

      teams
    end

    private

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
