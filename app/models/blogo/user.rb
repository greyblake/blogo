class Blogo::User < ActiveRecord::Base
  has_many :posts

  has_secure_password

  validates :password, presence: true, on: :create
  validates :name    , presence: true
  validates :email   , presence: true, uniqueness: true
end
