module RatingAverage
    extend ActiveSupport::Concern
   

    def average_rating
        #  sum = ratings.sum(&:score) #okay?
          sum = ratings.map(&:score).sum 
          sum.to_f/ratings.count #ratings.average
        end
   end