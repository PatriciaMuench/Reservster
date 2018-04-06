class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.string :date
      t.string :time
      t.string :party_size
      t.references :restaurant, foreign_key: true
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
