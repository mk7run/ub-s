class User < ActiveRecord::Base
include BCrypt
 # BCrypt gem allows us to hash and validate passwords
  validates :full_name, :username, :email, presence: true
  validates :username, :email, uniqueness: true
  validate :validate_password
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  # getter method for password of a user
  # BCrypt::Password.new/.create returns a BCrypt::Password instance
  def password
    # if @password is nil (in the event of non-instantiated user they would not have a set password hash)
    # in that case we will create a BCrypt object of the password_hash
    @password ||= Password.new(password_hash)
  end

  # setter method called when instantiating a new user.
  def password=(plain_text_password)
    @raw_password = plain_text_password
    @password = Password.create(plain_text_password)
    # the class of @password is BCrypt::Password < String
    self.password_hash = @password
  end

  # for authenticate (validation), you can use the custom comparison operator
  def authenticate(plain_text_password)
    self.password == plain_text_password
  end

  # custom validator 
  def validate_password
    if @raw_password.nil?
      errors.add(:password, "is required")
    elsif @raw_password.length < 6
      errors.add(:password, "must be 6 characters or more")
    end
  end
end
