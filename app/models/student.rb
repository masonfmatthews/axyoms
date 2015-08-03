class Student < ActiveRecord::Base
  include IsScored
  has_many :scores, dependent: :destroy
  has_many :impressions, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true,
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
    uniqueness: { case_sensitive: false }

  before_save { self.email = email.downcase }

  default_scope { order(:name) }
end
