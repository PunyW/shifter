FactoryGirl.define do
  factory :shift_wish do
    employee_id 1
    date_number 1
    month_number 1
    work_shift_id 1
  end

  factory :work_shift do
    name 'Morning'
    description 'Morning shift from 8 am to 4 pm'
    duration 8.0
    start_time '8 am'
    end_time '4 pm'
    short_name 'A'
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
    user_role 1
  end

  factory :list do
    start_date '2015-04-27'
    end_date '2015-05-11'
    number 1
    length 3
  end
end