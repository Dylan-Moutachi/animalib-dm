class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :professional, foreign_key: :professional_id, class_name: 'User'

  validates :user, uniqueness: { scope: :professional }
end
