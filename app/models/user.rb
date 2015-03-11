class User < ActiveRecord::Base
  has_secure_password
  after_validation :ensure_token

  def ensure_token
    self.token = generate_token
  end

  private
    def generate_token
      loop do
        token = SecureRandom.uuid
        break token unless User.where(token: token).first
      end
    end
end
