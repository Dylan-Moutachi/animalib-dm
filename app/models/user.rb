class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  PROFESSION = ["Veterinarian", "Pets-Sitter", "Groomer"]
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?#, unless: :coordinates_exists_on_create

  has_one_attached :photo

  has_many :animals, dependent: :destroy
  has_many :bookings_for_animal, through: :animals, source: :bookings
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings, source: :review
  has_many :favorites, dependent: :destroy
  has_many :professionals, through: :favorites, source: :professional

  before_validation :set_profession, on: :create

  validates :first_name, :last_name, :email, presence: true
  validates :address, presence: true, if: :profession?

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Must be a valid email address" }


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def set_profession
    self.profession = nil unless profession.present?
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    unless user
      user = User.create(
        first_name: data['first_name'],
        last_name: data['last_name'],
        email: data['email'],
        password: Devise.friendly_token[0, 20]
      )
    end
    user
  end
end
