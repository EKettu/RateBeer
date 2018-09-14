class Rating < ApplicationRecord
    belongs_to :beer

    def to_s
       beer.name + " #{self.score} "
    end

end
