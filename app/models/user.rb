class User < ApplicationRecord
  include RatingAverage

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
  validates :username, uniqueness: true, length: { minimum: 3, maximum: 30 }

  password_validator = /((?=.*\d)(?=.*[A-Z]))/x
  validates :password, length: { minimum: 4 }, format: {
    with: password_validator,
    message: "minimun length 4, must contain one number 0-9, and one capital letter"
  }

  has_secure_password
end
