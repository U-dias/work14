class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations

  has_one_attached :photo
  before_save :default_photo, unless: -> {photo.attached?}

  validates :home_type, presence: true
  validates :room_type, presence: true
  validates :accommodate, presence: true
  validates :bed_room, presence: true
  validates :bath_room, presence: true
  validates :price, numericality: {greater_than: 1}
  
  def self.ransackable_attributes(auth_object = nil)
    %w[listing_name address]
  end

  def default_photo
    unless photo.attached?
     default_image_path = Rails.public_path.join("images/default_room.png")
     photo.attach(io: File.open(default_image_path), filename: "default_room.png", content_type: "image/png")
    end
  end


  private
  def set_default_photo
    default_image_path = Rails.root.join("app/assets/images/default_room.jpg")
    photo.attach(io: File.open(default_image_path), filename: "default_room.jpg", content_type: "image/jpeg")
  end

end
