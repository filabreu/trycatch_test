class User < ActiveRecord::Base
  enum roles: [:guest, :user, :admin]

  validates :username, uniqueness: true

end
