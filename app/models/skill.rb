class Skill < ActiveRecord::Base
  has_many :users, through: :skill_users
  has_many :skill_users

  validates :name, presence: true
end
