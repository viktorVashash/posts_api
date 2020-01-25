class User < ApplicationRecord
  include JwtConcern
  include UserConcern

  has_secure_password
  has_secure_token :auth_token
  has_many :posts, dependent: :destroy
  has_many :post_views, dependent: :destroy

  validates :first_name, presence: true, length: { minimum: 1, maximum: 20 }
  validates :last_name, presence: true, length: { minimum: 1, maximum: 20 }
  validates :email, presence: true, format: { with: EMAIL_REGEX }, confirmation: true
  validates :email,  uniqueness: {case_sensitive: false, message: "The email address that you have specified has already been registered."}
  validates :password, presence: { message: "The password field can't be blank" }, format: { with: PASSWORD_CONSTRAINS },allow_blank: true
end
