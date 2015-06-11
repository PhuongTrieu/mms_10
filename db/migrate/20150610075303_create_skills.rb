class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.references :user_skill, index: true
      t.string :name

      t.timestamps null: false
    end
  end
end
