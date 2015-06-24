class Project < ActiveRecord::Base
  include ActivityLogs

  belongs_to :leader, class_name: "User", foreign_key: :leader_id

  has_many :users, through: :project_users, dependent: :destroy
  has_many :project_users

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
