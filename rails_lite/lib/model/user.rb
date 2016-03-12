require 'bcrypt'

class User < SQLObject
  attr_reader :password

  # validates :username, :password_digest, :session_token, presence: true
  # validates :password, length: { minimum: 6, allow_nil: true }
  #
  # after_initialize :ensure_session_token

  has_many :links
  has_many :comments

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    if user && user.is_password?(password)
      user
    else
      nil
    end
  end

  def self.new_session_token
    SecureRandom.urlsafe_base64
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
    self.session_token = User.new_session_token
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= User.new_session_token
  end

  def reset_session_token!
    self.session_token = User.new_session_token
    self.save
    self.session_token
  end
end
