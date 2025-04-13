class AddGuestToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :guest, :integer
  end
end
