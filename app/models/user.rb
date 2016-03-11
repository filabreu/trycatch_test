class User < ActiveRecord::Base
  has_many :foos
  has_many :bars, through: :foos

  has_secure_password

  enum role: [:guest, :user, :admin]

  validates :username, uniqueness: true

end
