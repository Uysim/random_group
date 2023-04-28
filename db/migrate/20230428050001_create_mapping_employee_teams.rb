class CreateMappingEmployeeTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :mapping_employee_teams do |t|
      t.references :team, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true
      t.string :role, null: false

      t.timestamps
    end

    add_index :mapping_employee_teams, [:team_id, :employee_id], unique: true
  end
end
