class Team < ActiveRecord::Base
  has_many :users, through: :team_users, dependent: :destroy
  has_many :team_users

  belongs_to :leader, class_name: "User", foreign_key: :leader_id

  accepts_nested_attributes_for :users, allow_destroy: true

  validates :name, presence: true
end
