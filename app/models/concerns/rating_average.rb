module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    #  sum = ratings.sum(&:score) #okay?
    return 0.0 if ratings.nil? || ratings.empty?

    sum = ratings.map(&:score).sum
    sum.to_f / ratings.count # ratings.average
  end
end
