class User < ActiveRecord::Base
  before_save :downcase_email
  before_create :create_remember_token

  validates :username, presence: true, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX },
    uniqueness: true, allow_nil: true



  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end


  private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

    def downcase_email
      self.email = email.downcase if self.email
    end
end
