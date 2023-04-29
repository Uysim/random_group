module TeamService
  # This class is responsible for generating teams for blind date
  class Generator < ApplicationService
    attr_reader :blind_date, :prev_blind_date

    def initialize(blind_date, prev_blind_date = nil)
      @blind_date = blind_date
      @prev_blind_date = prev_blind_date
    end

    def call
      @employees = Employee.all.to_a.shuffle
      @team_dict = @prev_blind_date.present? ? @prev_blind_date.teams.map(&:mapping_employee_teams).flatten : []
      teams = []
      team_size, total_teams = TeamSizeCalculator.call

      Team.transaction do
        while @employees.any?
          team = Team.create!(blind_date: blind_date)
          assign_employees!(team, @employees.shift(team_size))
          find_leader!(team)

          teams << team
        end

        FindLeaders.call(teams, @prev_blind_date)
      end

      teams
    end

    private

    def find_new_leaders(team_size, total_teams)
      return @employees.take(total_teams) if @prev_blind_date.blank?

      @prev_blind_date.teams.map(&:mapping_employee_teams).filter(&:member?).map(&:employee).take(total_teams)
    end

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
  end
end
