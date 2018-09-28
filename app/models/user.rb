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

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?

    count_by_style
  end

  def favorite_brewery
    return nil if ratings.empty?

    brewery = count_by_brewery
    brewery.name
  end

  def count_by_style
    styles_sum = {}
    styles_count = {}
    beers.each do |beer|
      user_ratings = beer.ratings.select{ |r| r.user = self }
      sum = user_ratings.map(&:score).sum
      if styles_sum.key?(beer.style)
        styles_count[beer.style] = styles_count[beer.style] + 1
      else
        styles_sum[beer.style] = sum
        styles_count[beer.style] = 1
      end
    end
    calculate_average(styles_sum, styles_count)
  end

  def count_by_brewery
    breweries_sum = {}
    breweries_count = {}
    beers.each do |beer|
      user_ratings = beer.ratings.select{ |r| r.user = self }
      sum = user_ratings.map(&:score).sum
      if breweries_sum.key?(beer.brewery)
        breweries_count[beer.brewery] = breweries_count[beer.brewery] + 1
      else
        breweries_sum[beer.brewery] = sum
        breweries_count[beer.brewery] = 1
      end
    end
    calculate_average(breweries_sum, breweries_count)
  end

  def calculate_average(sum_hash, count_hash)
    averages = {}
    sum_hash.each do |key, value|
      averages[key] = value / count_hash[key]
    end
    averages.key(averages.values.max)
  end
end
