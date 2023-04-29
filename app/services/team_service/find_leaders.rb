module TeamService
  class FindLeaders < ::ApplicationService
    def initialize(teams, previous_blind_date = nil)
      @teams = teams
      @previous_blind_date = previous_blind_date
    end

    def call
      @teams.each do |team|
        next if team.mapping_employee_teams.leader.exists?

        leader = find_leader(team)
        leader.update!(role: :leader)
      end
    end

    private

    def find_leader(team)
      if @previous_blind_date.present?
        team.mapping_employee_teams.includes(:employee).find do |met|
          members.include?(met.employee)
        end
      else
        team.mapping_employee_teams.sample
      end
    end

    def members
      @members ||= begin
        teams = @previous_blind_date.teams.includes(mapping_employee_teams: :employee)
        mapping_employee_teams = teams.map(&:mapping_employee_teams).flatten
        mapping_employee_teams.select(&:member?).map(&:employee)
      end
    end
  end
end
