FactoryGirl.define do
  factory :work_shift do
    name 'Morning'
    description 'Morning shift from 8 am to 4 pm'
    duration 8.0
    start_time '8 am'
    end_time '4 pm'
  end

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