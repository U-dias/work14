class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :home_type
      t.string :room_type
      t.bigint :accommodate
      t.bigint :bed_room
      t.bigint :bath_room
      t.string :listing_name
      t.text :summary
      t.string :address
      t.boolean :is_tv
      t.boolean :is_kitchen
      t.boolean :is_air
      t.boolean :is_heating
      t.boolean :is_internet
      t.bigint :price
      t.boolean :active, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
