class AddBlindDateToTeam < ActiveRecord::Migration[7.0]
  def change
    add_reference :teams, :blind_date, null: false, foreign_key: true
  end
end
