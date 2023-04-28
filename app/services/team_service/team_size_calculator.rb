module TeamService
  # This class is responsible calculating team size
  class TeamSizeCalculator < ApplicationService
    TEAM_DIFFERENCE = 1
    DEFAULT_TOTAL_TEAMS = 3

    attr_reader :total_teams

    def initialize(total_teams = DEFAULT_TOTAL_TEAMS)
      @total_teams = total_teams
    end

    def call
      total_employees = Employee.count
      expected_team_size = (total_employees / total_teams.to_f).ceil

      raise "Can't calculate team size" if expected_team_size <= 1 # fast notify error

      last_team_size = total_employees % expected_team_size
      if last_team_size.zero? || last_team_size.between?(expected_team_size - TEAM_DIFFERENCE, expected_team_size + TEAM_DIFFERENCE)
        return expected_team_size
      end

      recalculate
    end

    private

    def recalculate
      self.class.call(total_teams + 1)
    end
  end
end
