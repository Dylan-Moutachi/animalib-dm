class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :animal
  has_one :review, dependent: :destroy

  validates :date, presence: true

  REASONS = ["Follow-up consultation", "Vaccination", "Sterilization", "Digestive diseases", "Trauma", "Other"]


  def start_time
    return self.date
  end

  def end_time
    return unless start_time.present?

    start_time + 30.minutes
  end

  def time
  "#{start_time.strftime('%H:%M')} - #{end_time.strftime('%H:%M')}"
  end
end
