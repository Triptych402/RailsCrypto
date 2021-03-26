class CreateBitcoins < ActiveRecord::Migration[5.1]
  def change
    create_table :bitcoins do |t|
      t.string :symbol
      t.integer :user_id
      t.decimal :cost_per
      t.decimal :amount_owned

      t.timestamps
    end
    add_index :bitcoins, :user_id
  end
end
