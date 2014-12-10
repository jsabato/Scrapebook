VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
require 'bcrypt'
class User < ActiveRecord::Base
validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness:  { case_sensitive: false }
validates :password, length: { minimum: 6 }
validates :password, presence: true

end