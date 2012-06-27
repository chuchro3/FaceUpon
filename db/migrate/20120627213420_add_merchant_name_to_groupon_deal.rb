class AddMerchantNameToGrouponDeal < ActiveRecord::Migration
  def change
    add_column :groupon_deals, :merchant_name, :text
  end
end
