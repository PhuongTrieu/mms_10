class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :team_id
      t.string :name
      t.string :abbreviation
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end
