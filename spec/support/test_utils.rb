module TestUtils
  def sign_in_capybara(credentials)
    visit '/#/login'
    fill_in 'email', with: credentials[:email]
    fill_in 'password', with: credentials[:password]

    click_on 'Log in'
  end

  def sign_in_rspec(email)
    user = User.find_by_email(email)
    request.headers['username'] = user.username
    request.headers['token'] = user.token
  end
end