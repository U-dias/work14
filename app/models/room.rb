class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations

  has_one_attached :photo

  validates :home_type, presence: true
  validates :room_type, presence: true
  validates :accommodate, presence: true
  validates :bed_room, presence: true
  validates :bath_room, presence: true
  
  def self.ransackable_attributes(auth_object = nil)
    %w[listing_name]
  end

end
