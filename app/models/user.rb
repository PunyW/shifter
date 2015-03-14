class User < ActiveRecord::Base
  has_secure_password
  after_validation :ensure_token

  enum user_role: [:normal, :admin]

  validates :username, uniqueness: true, length: { in: 3..15 }
  validates :password, allow_nil: true, length: { in: 8..25 }, format: { with: /\d.*[A-Z]|[A-Z].*\d/,  message: 'has to contain one number and one upper case letter' }
  validates :email, format: { with: /@/ }, length: { minimum: 4 }

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
