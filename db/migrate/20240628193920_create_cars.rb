class CreateCars < ActiveRecord::Migration[7.1]
  def change
    create_table :cars do |t|
      t.string :plate
      t.datetime :checkin, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :checkout, default: nil
      t.string :status, default: 'parked'

      t.timestamps
    end
  end
end
