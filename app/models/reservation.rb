class Reservation < ApplicationRecord


  enum status: {Waiting: 0, Approved: 1}
  
  belongs_to :user
  belongs_to :room

  validates :guest, inclusion: { in:1..5, message: "選択してください" }
end
