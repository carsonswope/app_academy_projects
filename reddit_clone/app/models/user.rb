# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_reader :password

  validates :password, length: { minimum: 6, allow_nil: true }
  validates :name, presence: true, uniqueness: true
  validates :password_digest, :session_token, presence: true

  after_initialize :ensure_session_token

  has_many :posts, foreign_key: :author_id, dependent: :destroy

  def self.find_by_credentials(name, password)
    user = User.find_by(name: name)

    return nil if user.nil?

    if user.is_password?(password)
      user
    else
      nil
    end
  end

  def self.generate_session_token
    token = SecureRandom.urlsafe_base64

    while User.find_by(session_token: token)
      token = SecureRandom.urlsafe_base64
    end

    token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

end
