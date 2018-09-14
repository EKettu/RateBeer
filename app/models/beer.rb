class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings, dependent: :destroy
    include RatingAverage

  # def average_rating
   #  sum = ratings.sum(&:score) #okay?
 #    sum = ratings.map(&:score).sum #ratings.average
  #   sum.to_f/ratings.count
  # end

   def to_s
     name + " #{self.brewery.name} "
   end

end
