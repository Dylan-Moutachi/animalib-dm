module StarRatingHelper
  def display_stars(rating)
    full_star = "<span class='star'>★</span>"
    empty_star = "<span class='star'>☆</span>"
    stars = ""

    rating.times { stars += full_star }
    (5 - rating).times { stars += empty_star }

    return stars.html_safe
  end
end
