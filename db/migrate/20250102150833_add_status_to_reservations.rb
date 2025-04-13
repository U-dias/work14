class AddStatusToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :status, :bigint, default: 0
  end
end
