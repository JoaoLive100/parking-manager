class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.string :status, default: 'pending'
      t.integer :amount
      t.datetime :paid_at
      t.references :car, null: false, foreign_key: true

      t.timestamps
    end
  end
end
