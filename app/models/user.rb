class User < ActiveRecord::Base

  enum roles: [:admin, :user, :guest]

end
