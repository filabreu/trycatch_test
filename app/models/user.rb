class User < ActiveRecord::Base

  has_secure_password

  enum roles: [:guest, :user, :admin]

  validates :username, uniqueness: true

end
