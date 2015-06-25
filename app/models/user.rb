class User < ActiveRecord::Base
  include ActivityLogs
  extend CsvExport

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

  after_create :log_create
  after_update :log_update
  after_destroy :log_destroy

  private
  def log_create
    create_activity_log Settings.activities.create, self.class.name
  end

  def log_update
    create_activity_log Settings.activities.update, self.class.name
  end

  def log_destroy
    create_activity_log Settings.activities.destroy, self.class.name
  end
end
