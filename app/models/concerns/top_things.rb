module TopThings
  extend ActiveSupport::Concern
  include RatingAverage

  def top(how_many, array)
    sorted_by_rating_in_desc_order = array.sort_by{ |a| -(a.average_rating || 0) }
    sorted_by_rating_in_desc_order.slice(0, how_many)
  end
end
