class AddMerchantNameToGrouponDeal < ActiveRecord::Migration
  def change
    add_column :groupon_deals, :merchant_name, :text
    add_index :groupon_deals, :merchant_name, :unique => true
  end
end
