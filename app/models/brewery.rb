class Brewery < ApplicationRecord
  include RatingAverage
  extend TopThings
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 1040,
                                   only_integer: true }
  validate :year_cannot_be_in_the_future

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil, false] }

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2018
    puts "changed year to #{year}"
  end

  def year_cannot_be_in_the_future
    if year? && year > Date.today.year
      errors.add(:year, "can't be in the future")
    end
  end

  # def self.top(n)
  #   sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -(b.average_rating || 0) }
  #   sorted_by_rating_in_desc_order.slice(0, n)
  # end
end
