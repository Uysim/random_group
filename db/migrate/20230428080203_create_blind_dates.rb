class CreateBlindDates < ActiveRecord::Migration[7.0]
  def change
    create_table :blind_dates do |t|
      t.date :date, null: false

      t.timestamps
    end
  end
end
