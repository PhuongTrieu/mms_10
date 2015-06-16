class CreateSkillUsers < ActiveRecord::Migration
  def change
    create_table :skill_users do |t|
      t.integer :level
      t.integer :used_years
      t.references :user
      t.references :skill, index: true
      t.timestamps null: false
    end
  end
end
