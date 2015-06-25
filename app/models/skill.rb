class Skill < ActiveRecord::Base
  include ActivityLogs
  extend CsvExport

  has_many :skill_users, dependent: :destroy
  has_many :users, through: :skill_users

  validates :name, presence: true

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
