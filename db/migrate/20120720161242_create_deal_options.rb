class CreateDealOptions < ActiveRecord::Migration
  def up
    create_table :deal_options do |t|
      t.integer :groupon_deal_id

      t.integer :soldQuantity
      t.boolean :isSoldOut
      t.string :value_formattedAmount
      t.string :soldQuantityMessage
      t.text :title
      t.timestamp :expiresAt
      t.string :buyUrl
      t.string :price_formattedAmount
      t.string :discount_formattedAmount
      t.integer :discountPercent
      t.text :details_description
      t.integer :maximumPurchaseQuantity
      t.integer :optionID

      t.timestamps
    end
    add_index :deal_options, :optionID, :unique => true
  end
  
  def down
    drop_table :deal_options
  end
end
