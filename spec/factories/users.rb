FactoryGirl.define do
  factory :user do
    username "user"
    password "password"
    role :user

    factory :guest do
      username "guest"
      role :guest
    end

    factory :admin do
      username "admin"
      role :admin
    end
  end
end
