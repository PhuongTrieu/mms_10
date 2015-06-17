class Team < ActiveRecord::Base
  has_many :users, through: :team_users, dependent: :destroy
  has_many :team_users

  accepts_nested_attributes_for :users, allow_destroy: true

  validates :name, presence: true
end
