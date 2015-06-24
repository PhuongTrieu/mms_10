class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :skill_users, dependent: :destroy
  has_many :skills, through: :skill_users

  has_many :team_users
  has_many :teams, through: :team_users

  has_one :leader

  accepts_nested_attributes_for :skill_users, allow_destroy: true

  scope :users_not_in_team, ->{where Settings.sql.user.team_users_scope}
  scope :normal_users, ->{where Settings.sql.user.normal_users}
end
