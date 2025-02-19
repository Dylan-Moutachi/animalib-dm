class HealthRecord < ApplicationRecord
  belongs_to :animal
  belongs_to :booking, optional: true
  validates :history, presence: true
end
