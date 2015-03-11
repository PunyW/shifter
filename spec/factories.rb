FactoryGirl.define do
  factory :employee do
    first_name 'Kalam'
    last_name 'Mekhar'
    work_percent 100
  end

  factory :user do
    username 'admin'
    password 'Admin123'
    password_confirmation 'Admin123'
    email 'admin@test.com'
  end
end