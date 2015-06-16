class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :skill_users, dependent: :destroy
  has_many :skills, through: :skill_users

  accepts_nested_attributes_for :skill_users, allow_destroy: true
end
