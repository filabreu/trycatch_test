class User < ActiveRecord::Base

  has_secure_password

  enum role: [:guest, :user, :admin]

  validates :username, uniqueness: true

end
