FactoryGirl.define do
  factory :user do
    username "user"
    password "password"
    role 1

    factory :guest do
      username "guest"
      role 0
    end

    factory :admin do
      username "admin"
      role 3
    end
  end
end
